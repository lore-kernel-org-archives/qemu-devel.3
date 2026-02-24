Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36B2F4BB67
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwKz-0006vr-9t; Tue, 24 Feb 2026 12:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwKq-0006vW-QY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:36:37 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwKo-0003kL-OB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:36:36 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so234337a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771954593; x=1772559393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8Mb7JJ31wJsv3i9pLvO2NVdO67ZDNDABuR6kkDT74s=;
 b=WjA+Y+kuq9Hf6+mso1JjK3ZeHd3MDVSTzjPnX5rQPqP8oE4tS5VKA1TqN52jQtBQcu
 I9oCORxiSagXjU4vd7q98BeoJzqcL+2ZnS5jcvYRF3rXZmvOy37rxr0/DiPLgpzTVRWs
 HWW0XoZuaGFRPT9YgZtLPFgS4krVhgRq/O+LC8ATsEh2YVoq48ctKp/CrbFwnG4D78H2
 trRZtmrqQK4BxtZuzbaYKu26Cy8VrxCKf2RHVpVx04C6KpJkcAQfxn/7V0mz/8btFzd/
 FdWwK/SDCE6Tn9D2Pc9GEVi5gaN/zI5OsQC+mJd0y7s6Bqi8r8uFv3PZzR7h9N8MFu6c
 myRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954593; x=1772559393;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8Mb7JJ31wJsv3i9pLvO2NVdO67ZDNDABuR6kkDT74s=;
 b=Vw0Fkx+QamOJxDDbfoXyjeKB8pPSHay1/R3eIrybzymRD0Baq3qEBRpKcn7oUk4ySb
 10I8sHJ+9N4wMHiLIq4eEWNdjERh0uqpQdPK0OS4EdG6qZc6Cf3ZqJGQI/jxzWUn4bYg
 GUygyTIRttW9y5iRVxEruBmwVl8vQBCfkF/EPLFT/0/WEBUMqW3bpTk0TZK6dlvPztZj
 sDaC0WggcEO4MygrmiJtP8RBWWd8+xyb7HTvGJaB/GCyp9uHhY/r0hIC6DrkvbxHHuvf
 IhvjF69wzyb3QSjE9ZGro70ehS7TIF/3KLFHds1d6s4ubTIIfcfJA1swXrSIhYvnLrbp
 eZcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtDS2NF74QiLpFWUb8JYrHN4DvFCsxIYwZxmwxezxnx1OO7NUx2e/qa5NM2u0D363s9U9n1FqKOTrh@nongnu.org
X-Gm-Message-State: AOJu0Yw61gVdSHJ/hNJgGpvjwoGTEJTiM1tARLFNgffJRTI8eGY3Ww43
 g9dRUOMe2m5vl5/4xY61dGCY+dfEzDoaz0+b0XNoQVPrS/ZcJj+LXyY0vZz4QODf1F4=
X-Gm-Gg: AZuq6aJ/a4xGXKL1DLcu0cFU0saZTcdvQZjkXDQLMVdQisCtF0clS0T8dn4jLM+7vSn
 vnlpZOFUXrdTneUE8j2MRHUG7szSWSQL6q/L/aeRSlGwee4K6v4DNR5BnojJQPflk1MZJ469xUR
 /6fo3rqscX8/a2qOQPrTWcEgn/Cs20B13XlmaefW6oRGWx+hmG762FBBKaXS/XGlgE6H0J/J1sT
 SFn/jtkb8XT0UVDvP4jeuUmv/J76jpor/+0IKwYOM9KW9ttbgHGdChE8JNce9ky87pWF6x1gCgD
 jUtXYODzysTqMVKqZwPjauu0/5oJZP7UH+b/yvAuLVYIM4m6jnzh+P3WBwdbuPT8w34xweGfgUx
 qGjixAVzofL2wbBv2WahBASUMzc2NHLEAyK7ZgUd14eV/2ddOK2O95Dpwkysw8w32YNfzOkTLj8
 gCeTYb0CeOn0PR3MTo1LowXIo=
X-Received: by 2002:a17:907:9620:b0:b88:9760:2df9 with SMTP id
 a640c23a62f3a-b90819717edmr791318966b.11.1771954592522; 
 Tue, 24 Feb 2026 09:36:32 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084a4d6e1sm447803266b.0.2026.02.24.09.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:36:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0712A5F7B4;
 Tue, 24 Feb 2026 17:36:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Kr=C3=B6ning?= Martin <martin.kroening@eonerc.rwth-aachen.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
In-Reply-To: <0DF0CF94-9EA0-4AE7-A0BD-49D4217C6837@eonerc.rwth-aachen.de>
 (=?utf-8?Q?Kr=C3=B6ning's?= message of "Tue, 24 Feb 2026 16:07:58 +0000")
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
 <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
 <CAFEAcA-P2xqNO21rMyt2VA_tRf9yzWh8qtJFggGr4Mn-AWjj5g@mail.gmail.com>
 <00BB587B-792D-4725-A42C-AE87A201C2E2@eonerc.rwth-aachen.de>
 <0DF0CF94-9EA0-4AE7-A0BD-49D4217C6837@eonerc.rwth-aachen.de>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 17:36:30 +0000
Message-ID: <878qci3uxt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Kr=C3=B6ning, Martin <martin.kroening@eonerc.rwth-aachen.de> writes:

>> On 22.01.26, 14:16, Martin Kr=C3=B6ning wrote:
>>=20
>> On 19.01.26, 10:39, Peter Maydell wrote:
>>=20
>> > On (2):
>> >=20
>> > > Alex was worried about expanding the use of `virtio_is_big_endian`:
>> > >
>> > > > Hmm looking at the description:
>> > > >
>> > > > /**
>> > > > * @virtio_is_big_endian: Callback to return %true if a CPU which s=
upports
>> > > > * runtime configurable endianness is currently big-endian.
>> > > > * Non-configurable CPUs can use the default implementation of this=
 method.
>> > > > * This method should not be used by any callers other than the pre=
-1.0
>> > > > * virtio devices.
>> > > > */
>> > > > bool (*virtio_is_big_endian)(CPUState *cpu);
>> > > >
>> > > > I'm not sure if we want to expand the usage of this hack. I think
>> > > > Philippe is hoping to get rid of these warts eventually. Of course=
 we
>> > > > could rename the method and just provide a way to get the current
>> > > > systems endianess.
>> > >
>> > > While not being very familiar with QEMU's source code, something lik=
e this
>> > > seems necessary to me. I can rename `virtio_is_big_endian` to `is_bi=
g_endian`
>> > > and `cpu_virtio_is_big_endian` to `cpu_is_big_endian` if you prefer =
that.
>> >=20
>> > The reason for naming these functions the way we have now is
>> > that we really didn't want them to be a "this looks like the
>> > right function to use for my purpose" general name like
>> > "is_big_endian". Almost nothing in QEMU outside the CPU itself
>> > should need to know about the data endianness of the CPU,
>> > because in real hardware the devices can't tell what the CPU
>> > is set up as, they just get/send data. The exceptions are
>> > legacy virtio (which is a mistake that was made because nobody
>> > was thinking about it in the original virtio device design)
>> > and some oddball interfaces like semihosting. So the name is
>> > intended to push people away from using it (and towards e.g.
>> > target_big_endian()).
>>=20
>> That makes sense. How about something like `internal_is_big_endian` and=
=20
>> `cpu_internal_is_big_endian`, then? I am just making things up, though.
>> Given my limited experience with QEMU internals, I am not really qualifi=
ed
>> to choose any name.
>
> Is there anything I can do to help move this forward?
> Should I send a new series that also changes the names to
> `internal_is_big_endian`?

Sounds like a plan, also make it clear the very limited use cases for
using this helper.

> To me it sounded like the technical details are fine to all of you.
> If this needs further internal discussions, though, I am happy to wait, o=
f course.
>
> Cheers,
> Martin

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

