Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068F1C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aF0-0007Ws-07; Mon, 21 Sep 2026 05:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aEw-0007Wj-Tz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:23:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aEv-00031d-En
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:23:10 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c5so2133966f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789982587; x=1790587387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ehdIRPo0sbrI+9Np6lxRbh2udP4bnu6lyFflulA8RMQ=;
 b=bqBj3uK9WVXFehg2VBVYAN7JBCDi+NBmOWeqT0PC7lKF83s0RuyVkMYYrrERC1BLO8
 FGIiesnbdMD5C78ZtBHWLfsAE183tCNNfrk8/d2yAdJESbkerY2X6KIGd3R+79dvDUiY
 2XuJQ0pRwjQnY5XB3+Y6FmH1tfTZORS+BnLP4X9o1sXzuUHcI7/W2xjzWgeC17dSUn7c
 QSLmrG7YJf5eIMAbtnE1iglDPnuYZ7SwWW7W5Q9SxHgweLriLeoj76RHj3IEmHt6HMwc
 CnmHIcO+QCmd6DnMJvPnTpDT89/muWHe1oqAdF/tMWswp6uR49op5SMjYA84H8We/y86
 Px4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789982587; x=1790587387;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ehdIRPo0sbrI+9Np6lxRbh2udP4bnu6lyFflulA8RMQ=;
 b=KEkHWv/pXv80Vm8eDQ2taue7JlBVwv8PCthML3M15Q0EQgGUfLFtuDCJz+/RAqr7Ws
 BjRvciDJblItEk4MHxaA+upk3HCdy6rFkE7T+Oo4cP4fspeiLrQ3d8k9Q2yjCVWhpQVG
 q40h1xOdGN3G9cowhVN7QwMz6p8lDMtA8e+mNJTjnPRftzhwXVlikMGAiJzBrcF1H6N4
 p5+lBj9M18xwjcNbuvpr29Yz/e1t02w95+ORKuJiFOROn8Rm8HPPSs/+UbHb9oFM2B/f
 jo+dq4mWc0MSfMcDhakRVCcJuRmrPfO7YJzhJUh9PnLDCqJtD41+/PwZXOhTFHG+dDS1
 gttg==
X-Gm-Message-State: AFuF++noPmfl+UHWzFRPLi1fi7RKujSavfnyZl+Q8fljzyFaipkHnstf
 2gA7TjPSA5iSBBHgap+egDejEcdGOHg0trDYU95aqVWl4hftV0a5rFlNRe0c8QqwmlE=
X-Gm-Gg: AYBFou1i3Qc4EBIYFuDjq11CdmptjdShrs+tQNNBcAl7/e/2ljAxmv0cmFUvnr3xMrz
 4aRvpzCjO14ezpzKkXaubGXnGjwaDWZx7MeicOvmvNDGxAUk74diiBQEQVMrbsxvmpvtLAl13sZ
 e3lHZe5zn1+KBO3ry+c4arzpkT752POobg+b4olo051wQ0Bz2eyUIBemqZwUUetHYQmwN3CH93j
 1s4yRAVmWjCi+zNMOZJwQvuByJBDeuy3KgXE6Zu1zwck8RDjZ9SxSkgnn/pZsK5wwzOqvbPmKOo
 Q+mFgNG0gXOqm8LfeE7PL8aeVW5oLkpLdL9sI7ME+v6Kmf/XgSmiAccGUsUYVwMri3rjHT5DDch
 6GH7e66vPlmceSYQB65g3plhvxIKLAAH1n/HC5rdlfQXIGUAVmKMQyzA9YvOBDZg67QXPeLcTgU
 /YkUyyuVJdywX9TSpNVz3dXnWgveKncLgBBB8qwLlB6slFIvsFARA8Tj+JbFgHVQon5nkXzkvw/
 OEVwREovq4=
X-Received: by 2002:a5d:5d13:0:b0:487:73c:3f9 with SMTP id
 ffacd0b85a97d-4871e22069amr18298750f8f.22.1789982587506; 
 Mon, 21 Sep 2026 02:23:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724596604sm21923793f8f.30.2026.09.21.02.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:23:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 91A605F8A9;
 Mon, 21 Sep 2026 10:23:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: add final instructions
In-Reply-To: <20260921075251.12831-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 21 Sep 2026 09:52:49 +0200")
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-3-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 21 Sep 2026 10:23:05 +0100
Message-ID: <87ecen0xhi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Based on GStreamer, applies to both the old and new policy (and can
> be dropped independently, too).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

