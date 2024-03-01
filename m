Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB97C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg3WJ-0005PE-HC; Fri, 01 Mar 2024 09:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg3WG-0005O2-Jj
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:05:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg3WD-0001xv-H7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:05:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so1082691f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709301943; x=1709906743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvRcj/lRDxwSKa/nT/9N7/Vu7IjmpxIlQF47Bc5vUnk=;
 b=F56XTIq2S68Qq5IXZYhTnYLjR30AySG+xY4qsR3K7A8vdVtF/A+2nmQ/EjiTyAaabF
 3RS7NwvK6zLZD4ndBM9Q3ufIUxh5Ot/1oD5fiILQrE5Q1nz04RnPYtjRNTlGR671W/4/
 249DgABnv70t+p/HpfB5XGqHeNpV6acDiXnGhbcDwpgciXROdx6GZmPQY0n60Gt7Fop5
 S3jHJfDMMgzXRmFtf9s/i1gS7ACUVpJMdL90eRRv7fq1T71HU/fwOKQcEhgEUmMs72Vs
 ce8VByU9TQ0vQwDySL8n4ilL7e8r+z2IeKfwPEu3+gm9INy7UQmS2QhOelumDjqrLJuU
 2i2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709301943; x=1709906743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EvRcj/lRDxwSKa/nT/9N7/Vu7IjmpxIlQF47Bc5vUnk=;
 b=F2gE2zDbMoZnuWFqpyFyEUPKmNm5qkQnWInqh6D4BM2RUq1EVvwKGlwkH66mm9w0WH
 Z+Wjb8zagNhAaw04v/+6YbXBOjORad8HMeAUhzvtwvA+/ggGaSoudhKDpOm2cTyXNsUN
 EvjUABMrwXoaxfD63RcUQYb4M7KfllLV68Pa9hwUegqoPwGS/usS3+NYQ4YRCoy2VnxD
 YpmO4mbNGZzJKLiaizIo4uC7v4jZ0Ca6BLeLw+IrlzCybTM5U7xMWY2yP1ogFuUW+bE1
 SZ2qBeDhZV094vBf6sMPFNnT9ffU6OC7F8wnNlfhwcxPmqtqo5DQavBdBg+QJ/1mBGTb
 u3sQ==
X-Gm-Message-State: AOJu0YxoLaX0Rh9Tp5jw7LsSaeLUavX3QBlLBZ7o2WMEpDrAYaxzOFzy
 ih5o0uO6pp+zlSPl6mQGHdUGtZq91eCab1onnWrWSbVoPtqWlsUp1/iwPOrTDKY=
X-Google-Smtp-Source: AGHT+IH0vRBDHW2rDFP3hgccyW/FGrjbFZjzIJZDaHlWCZN9wENhqaERMhpoLlTDZp91yXJWbVVJEg==
X-Received: by 2002:adf:f28d:0:b0:33d:38cf:aa73 with SMTP id
 k13-20020adff28d000000b0033d38cfaa73mr1336560wro.47.1709301943499; 
 Fri, 01 Mar 2024 06:05:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh3-20020a05600005c300b0033df1dc39f0sm4918552wrb.4.2024.03.01.06.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 06:05:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4D2F5F796;
 Fri,  1 Mar 2024 14:05:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: <qemu-devel@nongnu.org>,  <sstabellini@kernel.org>,  <jgross@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>,  Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  "open list:X86 Xen CPUs"
 <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v3 2/7] xen: add pseudo RAM region for grant mappings
In-Reply-To: <20240227223501.28475-3-vikram.garhwal@amd.com> (Vikram Garhwal's
 message of "Tue, 27 Feb 2024 14:34:56 -0800")
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-3-vikram.garhwal@amd.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 14:05:42 +0000
Message-ID: <875xy659op.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Vikram Garhwal <vikram.garhwal@amd.com> writes:

> From: Juergen Gross <jgross@suse.com>
>
> Add a memory region which can be used to automatically map granted
> memory. It is starting at 0x8000000000000000ULL in order to be able to
> distinguish it from normal RAM.

Is the Xen memory map for HVM guests documented anywhere? I couldn't
find anything googling or on the Xen wiki. I'm guessing this is going to
be shared across all 64 bit HVM arches in Xen?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

