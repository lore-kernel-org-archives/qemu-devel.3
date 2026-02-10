Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D3EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlF-000139-HL; Tue, 10 Feb 2026 04:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjl8-00012S-GD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:10:14 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpjl4-0004VB-U9
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:10:14 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7927b1620ddso77034587b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770714601; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbLEx1VOd4riSPx7y90KTRYw6/84y7GC4sFPzmIc6bq5HWoy26tOgbmdl3ud9KRPBL
 aSBteeA6QL7n4MBDjnYBf6jN2MFe7pDPNa+BjT72GBysTuqTXzHtQYdigyParwkbIJJj
 rSyB6kykElncIeaw9dkWQxKgvYzjWcuVPd/g16kJorglGtZlekgLYOh38Pj56Ka34BBv
 GyG5K1giQiJzpkHBc37TELsoT2yLtmj0D7zii22bhu8hdYO7GYYufj2IH7i6GBIrz6Oj
 JhIWrym9MvzmhcIimH1PSAdKtFYEanlg0baZsighqAdyKieq4XbPB77vwilUn4ynjfWC
 sZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YvRSKSKQq9uMqRb3raty8qrvFGagbWapxBlav4OrMs0=;
 fh=NiWPs7/oy9qB/ksV3lDFVeenmO44KI7ALf0eB/+qLts=;
 b=JZ2UbIg31dQN5gFG25dWvPc+/T50Mg1yTibUow6n7u+xlgq/wSXRWM0zRZGoA5eHQp
 hRTAmJGVcM+YG8TMMBEbnn1BeEFXyBVO/MWA1DO3eZYdwRNg0kVevmlDXzrT352euU3w
 D+tZ0X9CtTfM0EwJCMeJVqCv4NsPzSDIYWSIlgQxBl64OI/DjRCl9gYTd77M2QnE96SY
 g/oCvEKSdNK76YkTpGpDRvMLEH5DVTuGWUo9SXzBezOX94/Zw2KkpjqUXgq0y5ruTwH+
 opWewZj35m995Ak0H0Ab4MlK6dI+86fCapAumPEyppHq2WfPW0Tm2ZKOwrvr30zoPGr8
 rhlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770714601; x=1771319401; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YvRSKSKQq9uMqRb3raty8qrvFGagbWapxBlav4OrMs0=;
 b=lJQWhVoCACjenqSBKHAjDER1TYYvilxEVnLZ1DT+EHrbJJ9CeMNFgyaO//fbsePvxN
 eU4atoEB0ja6rxq4GpJpEYCqSkFkBpJin+C/RAuvlVSYX70kn5O5eiS2ldVbUw34Hf50
 JI5dNEtVeaon5EQIQRHag0cGRKbMUTNNeF7XOP9cLkoMK9T4a+IqnXLuP+owVovWoa99
 ej6yf6RWnUdQQq5Cnf6IEppebD/+TZi0U+PCWBP51q7+QgwxvykULpapMEbdji/IFB2a
 2HH7yggmwaNcbpdu2493JJeAL/LenYJl15KHK88XJ2BqIgYS2bdynC1LrT/WZyi0HPda
 zDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770714601; x=1771319401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvRSKSKQq9uMqRb3raty8qrvFGagbWapxBlav4OrMs0=;
 b=Uf8iajqjCwI7V0xrA/+qIxqjupu+8TnoQMRKV0oO3MizuJMifCQyj92tV+l1f6cEg6
 kEeM3YeJW+eHgZXSceiesU2KuFu4MevaZEgvSpqAFXGBdJHkSf7Nn6p/KGHi2dA2W8Ym
 UoTe0AdKKCIogHkmqrCtY1V3yjpe3yRt6p667H51YniTvvL/X03x2smmv8Vk944Kmeb0
 Wr/WvjYBriudE62K/QrBcQhDq/cGxQV3zUmxzCQ4bgVFKmuY7DLt0QypC2O/nrZtVqH7
 vr6qcnUjZjHHR3EdG9FRODc0aRXgky2CsYIEZ6u7HU17v4EAFg0F6+Ad6utRK5UDbd+c
 pE3Q==
X-Gm-Message-State: AOJu0YzO/iP+oPX9i+UK2zAt12DzFxaBY1QiRAt4qTIP5cCPwIeY7j/5
 DMl1OlRJRl+UO4l5c+9HtPY+OD92qr8pTJwcR/5Qb+18L+XxoayB5zp7r6Z5z23Q6QAFTiuOcQ9
 Djf30SeLq8VaqCo7j3DpuzU1Gu5wKDE8XuvKOVJL/LA==
X-Gm-Gg: AZuq6aJR/Oc8UCrDEUZyw+L9n3LZKceD6J820taDlpiRm7vHeQUYlIuoysv0UfRZEa8
 MbK7SHY16SSuEMznBf3bsHazXqHzcS8OkuqV9TX+4W4jwPGvPE8siCSPPAWTdl1sHZrVGVGoVrQ
 H1UdZRiSIGjQARshSa/kIBYtpSNkklm25BP9dKX3ISbScpeTyup/MtMEmGIApREPutRX9A2IyqM
 nVNxcKmcRNOQw/TWsBRXQ6RoNSNB4P4JcIZb09yV08pHnIVt/sWpvMgRzc/KzCPaH27E7e8GVdW
 urWYBEekkBqBLkoq03Zs9huIKVHruPN+Xmzu5la0yJhVegSNMRniNdQj60V3kWzEjLWP6xi3VWK
 vKg==
X-Received: by 2002:a05:690c:61ca:b0:794:c15e:df6b with SMTP id
 00721157ae682-7965e61bbb2mr12397707b3.31.1770714601511; Tue, 10 Feb 2026
 01:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20260209144508.45268-1-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Feb 2026 09:09:50 +0000
X-Gm-Features: AZwV_QgskMsme74OWCB8tOwCAdzCf4n_tQ8N4-yIWC0nAfZ5CJA4uiv1w__1G2I
Message-ID: <CAFEAcA_61MdmziTNJ0MHhnLvmPoQdxctQ=4C2Sz-R+T-VmjnQA@mail.gmail.com>
Subject: Re: [PULL 0/9] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 qemu-block@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, pkrempa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 9 Feb 2026 at 14:45, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit c4a9d49c7b23a02c646ebac756519c15a24f7ecc:
>
>   Merge tag 'pull-9p-20260207' of https://github.com/cschoenebeck/qemu into staging (2026-02-07 17:46:15 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to a67819adb2212977360e9290bd005badb07dd2e4:
>
>   docs: add SCSI migrate-pr documentation (2026-02-09 09:27:30 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> Andrey Drobyshev's qemugdb script improvements and my --device
> scsi-block,migrate-pr=on|off live migration support for SCSI Persistent
> Reservations.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

