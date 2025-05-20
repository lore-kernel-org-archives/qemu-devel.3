Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEAAC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPGm-0002UW-2v; Tue, 20 May 2025 11:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHPGi-0002Th-5z
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:52:40 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHPGc-0003Gq-Lr
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:52:39 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad5a11c2942so40126166b.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747756347; x=1748361147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Asp1ERP/PB/8bsjkzlfIt4A92qanv6neIKuBkn4aAM=;
 b=KtaM+6+eZ5ARnr+wSyJg1cp1BHm+eyZhexichkn2B2O/2DA5IIKO7/12/7A30dHmJM
 uPlU1s+kifiwTHqCYySRPNkRSOc9jS9poZjI8sxkGho/sOK8axN6PoSADhSQ2x5l6tnb
 ehsg4Kb0CSYWkFJl4f7U1Y3DgbDMwZqVHozdpe4kyB8gx0WCkLny7ZFwyjxdLBJa95RM
 wPCVCTV+AcbAFantW0pgZ/NUhcmRz7EMidYoQKVDembN+PkCDhFMgCJOYL64NU+f1Aad
 dkf5J298w2Fpe7+GcuYUUa/OFD8saYapCC4aMGLAiAW21MbuAE1gyxFZk012Oxw544Wv
 6mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747756347; x=1748361147;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Asp1ERP/PB/8bsjkzlfIt4A92qanv6neIKuBkn4aAM=;
 b=C/VqdsyqJQCzmdPySO/5wVcGNZCBYNM5CG0eUvmY7Y3X9kOg9SqQ3tWfq6nf9O6Kr7
 zcV9+yWaKnh90eSRcN/UYidGEvCi6flfSt1ao8q9PT5e1C02P9OOSRrvQ9SwucErItEW
 3QEO2TvYUq5rTrMGPVzFJkaLc0BRwVBT0zbcpHRjxVC2q2BoesWDRPmr6CoJC0eZH7sO
 +ciyu0KRV1fFVSA3Tk8aVcRd6j5rSzLUh0c0N3yxqhoWu9tYDVIgRZtq/g4YpCVC0peU
 /6gNTbylk1eP26+gLti9+zndVpgNOPjdTfHKFx1DcYXlpV4/n3wpk/DLB0yjq/Z71Hy+
 5YOA==
X-Gm-Message-State: AOJu0YxDVIhSlXOXxy1N4RF76CXh7vmrxsYbYqYRyfn9glMh5PrETg12
 /eGEsGmwLlCWRTh4JVc0XLunKd4qQHkbBu33W0jZyr7J+UQAQ/DGVB9fNbgg3by5YBQ=
X-Gm-Gg: ASbGnctSXPg3HavipGqNkRCOuwE2LIh91EKQgejw0l2B8KQMN5LwaGH0XmGYToMSWrH
 AnCbTk6dw/5PNQbl69UMBPdBOdO7S7xYXWUgSJZHjODfajZKhlOq2LBzWnXwDqYX78Mu3mV7CiC
 CP7+DAYxRT08S5xCbbVxVOhKGISypSxLDKpw5LJCOrvJh3rV8AY/iZdQA6ITjPZd2dwF0RH768c
 LiJ/iN68ZQdMSZM5ZqEcNnDJvKsWRyBzBGj0fvDYZ2EE372uJzO6sUHxYHXk4/zGYmnx86F35uJ
 8hbTvk8DRUtt8ntHMvjW2+9GaaZIy3ve3F03zwhXKhN7Aq5ZtFhu
X-Google-Smtp-Source: AGHT+IFMJsTTt9GyhLBXfxSt2K1nj8Z164pt0qlGGn6IdcAr4IDt3HZ1NjeBponr/2txHeM77OBenQ==
X-Received: by 2002:a17:907:c24:b0:ad4:fd7f:a4 with SMTP id
 a640c23a62f3a-ad536f9d85fmr1302979566b.47.1747756347309; 
 Tue, 20 May 2025 08:52:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca731sm737835166b.166.2025.05.20.08.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:52:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A95CF5F7A5;
 Tue, 20 May 2025 16:52:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Bin Meng <bmeng.cn@gmail.com>,  Tyrone
 Ting <kfting@nuvoton.com>,  Hao Wu <wuhaotsh@google.com>,  Kyle Evans
 <kevans@freebsd.org>,  Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Laurent
 Vivier
 <laurent@vivier.eu>,  Riku Voipio <riku.voipio@iki.fi>,  Harsh Prateek
 Bora <harshpb@linux.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Laurent Vivier <lvivier@redhat.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-ppc@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org,  qemu-riscv@nongnu.org,  Ilya Leoshkevich
 <iii@linux.ibm.com>
Subject: Re: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before
 binding
In-Reply-To: <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru> (Michael
 Tokarev's message of "Tue, 20 May 2025 17:50:10 +0300")
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-12-alex.bennee@linaro.org>
 <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 16:52:25 +0100
Message-ID: <87cyc39t52.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 07.02.2025 18:31, Alex Benn=C3=A9e wrote:
>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>> In case an emulated process execve()s another emulated process,
>> bind()
>> will fail, because the socket already exists. So try deleting it. Use
>> the existing unix_listen() function which does this. Link qemu-user
>> with qemu-sockets.c and add the monitor_get_fd() stub.
>> Note that it is not possible to handle this in do_execv(): deleting
>> gdbserver_user_state.socket_path before safe_execve() is not correct,
>> because the latter may fail, and afterwards we may lose control.
>
> Please note: this is linux-user stuff, which is usually linked statically.
> By linking it with qemu-sockets, we basically broke static linking, becau=
se
> qemu-sockets uses getaddrinfo() &Co.  The previous code, I think, was the=
re
> for a reason, - to avoid this linkage.

Oops, how come we didn't notice? We do have a bunch of --static targets
in the CI.

> How do you think about reverting this one and addressing the original
> problem without using qemu-sockets?
>
> Alternatively, it might be possible to split qemu-sockets.c into unix-rel=
ated
> stuff and generic stuff.

You mean move all the unix_XXX() functions into a new unit that ensures
we don't need getaddrinfo()?

>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

