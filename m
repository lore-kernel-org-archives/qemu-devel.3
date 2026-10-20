Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB87606AA1D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tIkn62IC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAi9-0006Bq-GC; Tue, 20 Oct 2026 10:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJAi7-0006BQ-9k
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:21:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJAi5-0000F7-M9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:21:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2359566f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792506060; x=1793110860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZoD9sr+Biab2NVqCPaY09d2onMgngitwRJlqw9WrGVs=;
 b=tIkn62ICyGeqiYi5DGjCE4/0ARAyEPzl6suwzykhQ1AJYRjTL3Wyy/AjonI4EZQeOY
 uR5zqxeNPukrg1/IxxBNW048870tz7klxpAL15XeJL4FNM9tfPHAH10bNQFohxU0rAKy
 gbb+SVBnoXbquf0FAEAy/5VgByvYB6KffZFdfMI9kptpxsJmrfMwJmVeRQ7ccSpfPOwQ
 tMiWAjgTu4l6snXPvw40aU4Ob23ADre7OQYfYv/npgfHTjXm8me9VecmfjL8zYoD+P6b
 +m3LgkuSUXmEeVkvj3GSf2b9Z8HmU197ibKjTvLQctHfpT7Nn8sc/3BnUboyfr4wMKV7
 zH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792506060; x=1793110860;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZoD9sr+Biab2NVqCPaY09d2onMgngitwRJlqw9WrGVs=;
 b=u3aArCtOufFjECe7l4MQbLcLiw9tPwL9epF+ZQMYVkNR1fho3CQe+qILEMyIdS/Gzm
 f5/7c+HfVnN8WAWOe9hNyGicKzBq3LdJ3bcopU7mB/SpJLi/T//qtPr2d9FJeOylyyUb
 hU7aflrEcc6rEasH3JtpwW0XmXRcknsmxoZr7WURhpijg7NYEwmJZJPdl304A3HiktTT
 Qx6yZrqWUfHvOyum3PpZcrLapI0Ou63itSF+VIGijEsfUgImfMrqwaiDRox85SFKqycX
 lCZGqwyj622VXCHTbQwOrjaT+JwNld5w4iMPPAj7XzqJzZyCWWsd4QQYMeqC2Xh/06no
 GCsQ==
X-Gm-Message-State: AFq9FYJu7F7fFy9SU63ZL/41VveeBaHm2j0PIa9QbmSqH17/b5obP3Ja
 4Oa6f4xvovF6mExC66wgbUqk0mEIuzUZ2Z25pNvhknVtoJ1WKJPmSB3UADcHaISxF6M=
X-Gm-Gg: AYBFou2p8Xq1JArK0a/HpI1Ldnl/r32qdoXBtX1QrK1qsBAZV/wy8bSd6TkVZPT5/+a
 R2vJb0sHhFYGz0wUK36oy4fqDzgKV8VwgKGdJJm82l8Y38DduEphso2/MJ8THYvEPXsad+m1Au8
 0rqdwdX2TBASxMnorEWTfQDTJJY7QNRoQaAVSUL/CJ8iuQPiY3FlqWijQRM1+7gq6QqRUGAdRa1
 FSO57HsLvjWLMCJ8l0SQSJ7ZeA7I4sA0GwsikSkdjYZQV6SBoZBpHxiZI1xvvzSPdCfzcMp0SUE
 93h12qwWnsA8F3jRLkR6IvaafPtxN7P1JuB1Giqp8TNO4S9uWjJcZaKmEY6KxemafJs3IKMgZJX
 GTvFAHH6P2w6nP4sxBttRnIeaCCP9vOTjDBYukOstWJMqgGUgg413UWT1uB81gU1zDdxxMhZ8i5
 96+rVNFvH/uGE/PAszeBpG3904iCWrzJy3Vi4ycB08GvA++Bhp9T1X31gPkg7GM9P1aGjmO6K/V
 0juBNQh
X-Received: by 2002:adf:fb0e:0:b0:48d:ffe8:ace6 with SMTP id
 ffacd0b85a97d-48e07fa701emr17116136f8f.42.1792506059455; 
 Tue, 20 Oct 2026 07:20:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d81035csm6834354f8f.15.2026.10.20.07.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:20:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 954C65F917;
 Tue, 20 Oct 2026 15:20:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Tao Tang <tangtao1634@phytium.com.cn>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Michael S. Tsirkin <mst@redhat.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>
Subject: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
In-Reply-To: <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com> (Demi Marie
 Obenour's message of "Wed, 7 Oct 2026 16:19:10 -0400")
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Tue, 20 Oct 2026 15:20:57 +0100
Message-ID: <87wlrc1mie.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Demi Marie Obenour <demiobenour@gmail.com> writes:

> On 10/7/26 12:29, Alex Benn=C3=A9e wrote:

(CC trimmed, IOMMU relevant maintainers added)

>>=20
>> Hi,
>>=20
>> The KVM/QEMU community call is at:
>>=20
<snip>
>
> Is this also for topics related to KVM but not necessarily QEMU?
> If so, and if there will be people who are familiar with device
> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
> faults are recoverable.  There is a virtio device I am working on
> which requires this to avoid either crashing the guest or allowing
> the guest to hog host memory.

We didn't get to this at the last community call. Is this something that
can be discussed on list first?=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

