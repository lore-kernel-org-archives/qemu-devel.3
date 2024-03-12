Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CDCC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzxL-0006PV-IW; Tue, 12 Mar 2024 07:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzxI-0006OG-IS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:06:00 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjzx9-0004dI-SA
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:06:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so6109580a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710241550; x=1710846350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0F86ewSYmM1T1nxCBxEvTW8lp9AN40udFid87USF8t8=;
 b=UOfwBJeTCQIH+VXelZ/rmpTNSwbomMdL2aKEMlPj6Ynj+YQqi1ZWIImGIIYcRJNeZD
 xRnXu/sDvuoyEmMQBkAYxSEjs09v++DnpiQu49SaKdpJXS1NEsdCrRU544hzErgQKFAO
 +4tMEHPWgTOIy0hELp+ExPTpml8YfBE29IvRKBwWcLOCUXG4qWQBsH3f83M5SeLPpY5T
 Od2hoHzphBRtI0Gw9GcT4/cVPsLBn8Yf0ek6MLRB0iwOFf2fnlbDYItYbV3DjhidTIso
 DFf3XB5QcbPwFuEHHx6PMx3lX9eyml1pem6PdEcoj4kq1FmZKPLwbXF4g53zvmOUvtws
 OrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710241550; x=1710846350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0F86ewSYmM1T1nxCBxEvTW8lp9AN40udFid87USF8t8=;
 b=M3qRFodfR+zLhXv2fewOsU592TTyDxuW5RDt3TtLgHM8SyvBQmewIo/u9IHIALO3Rl
 IBE4HBps2RgfjJaVao4J6TgwFUJcIQosQI2G7uqy+8mViurBx3zj/Lj29g6zuvjxfjh5
 j7l6UDoMNtO4K5sB8qZAwXbrKrk6BfrUAbC8A1yB4yDNNf/SGcysklqPZpX8F+Vb0qKi
 QYjju4LMqFzh+C3NbeIhr7ZcZIQid9EBE3JCQ7yTrySVJzIbjN21cGT7X3Kw6Db1u/vC
 JTsGEMX/4w66mp2r++Hf9iMHKxBXi1gok02zFJb13nKKDUlFGY5h+E9hqxWbfzfCxn/4
 K+Bg==
X-Gm-Message-State: AOJu0YwNZDq3i4n8WfSeXN8FJe7PYjPoxOo3ubgzt4ByhmORb/HAbd/C
 hmiTKc+Mj0KEKuZmKztGyMTIoX+PBC3hnODnCvjTl8OCD3izjTxUxyVOROXlNouazJiKJC+tZNl
 ZzkZduy/8IoZ3xTcxbjtw2b9wtUcqYEzpRbjvomsiujxaF1vK
X-Google-Smtp-Source: AGHT+IFFaEAweZiSxkTjoSvsV6ai0kwsawy+1FxlNUN7g6Sk+xikNFUKe/M7lNIVYyG31Kac6/BvpicoJBPm/xuG+mg=
X-Received: by 2002:a50:a44e:0:b0:568:7bb3:3b14 with SMTP id
 v14-20020a50a44e000000b005687bb33b14mr56776edb.8.1710241550023; Tue, 12 Mar
 2024 04:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240311165724.176168-1-kkostiuk@redhat.com>
In-Reply-To: <20240311165724.176168-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 11:05:39 +0000
Message-ID: <CAFEAcA_qyKVXzj0p814Xke2bQLNANpQ_eg4c-DYj1ZCTyorXJg@mail.gmail.com>
Subject: Re: [PULL 0/3] Misc QGA patches for 2024-03-11
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 11 Mar 2024 at 16:57, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-03-11-2
>
> for you to fetch changes up to bfded6fe62b859e337386ed3028b85743569a30b:
>
>   qga-win: Add support of Windows Server 2025 in get-osinfo command (2024-03-11 18:24:39 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2024-03-11-2


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

