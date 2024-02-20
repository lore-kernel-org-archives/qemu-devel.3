Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD8C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXXm-0000Tf-Ja; Tue, 20 Feb 2024 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXXj-0000Ps-OE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:20:48 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXXh-0001Th-29
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:20:47 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512b42b6697so3104306e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708464037; x=1709068837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=us3PHfw6uuC7qJAMn7pkS5Fi/QoUxqHzqfQ60LSSPfw=;
 b=wWSolZueeBQiN3wOg8mgkeGXpsXWJRizogoEuqCwpX7aHhrgD/Awgz5BHm5mQ2yiTk
 cQr8z42XWaH7I1pHLLySStDVuC0V9iCg/mopALJKKBVt8wkIRdzaxX1hm8tG5QcRzC9m
 3w7ZaMDkkjTW5g6vaB3FH8ewfVgHd/myBmfUKogqELhj1kNKGavvDbEO+8mb4zg1KLA0
 NNJ1hhh3zUxJw86MpFPCATc9pl1A+HbN+C4HbbLEOO+T08pKlBa3QpjtEr7M9VwmN4Ze
 IKsmlLkTfO/zPFU4EzbI5jqOLg86qRSMDGI8NfmbPT+hi4Z+B7rpFQHLByhN0Rq5Y7rY
 bQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708464037; x=1709068837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=us3PHfw6uuC7qJAMn7pkS5Fi/QoUxqHzqfQ60LSSPfw=;
 b=cR6+yzWqp5kHtXccS/0KzR6p7AbdA5Tq1IOuc+XfWez67Xijz6M0eigfTMqBg6eTqM
 fYT+E8qs15GwXsJh2u3tAT8i6QVN6H82YIpfPmiUVjqa9fqpPhsrNLe0KKuzN9/X/n5I
 Jnne4vQuu35OXxVHV0BFdpmJjoc93H7D+Z42WT96eWkrI83jfgNvcXHtin/nigYMHX0R
 qxDspDZepuZE9IVN/+S8LK5PnjQ5BCKKwv2G1e+LXJo6j1yb0Ndo9/Lo53CylQ/yBG8k
 lDBCPoNUDIioNEo35CeKJAqFm8rrIMd8PNMoMFLh7IPn04HKGrhIzpxqktcMCzAcVfCM
 T7MA==
X-Gm-Message-State: AOJu0YxAMwVpEgTNDerBs+PrB4fA3JRptSKHlqTAlw5IRvSYKIkJg44w
 bepkGp3xlBuwniLmeXTQ0TWen0XiRIckPDvc3itJL+3SQberDxosKRH/RbHQZV2CqaFvyO6stYZ
 +d889U5UpimOMh/46LyX+fCukAwu9gGgH0sWHPA==
X-Google-Smtp-Source: AGHT+IHCGV+h5otv4p2LOu6ux2vcvhvUZslZLUwIodYDA6v9NCrlHtG1HBZpUfeWJUDnqiWhtKjSWjCX9Zn4B/UBuWA=
X-Received: by 2002:a05:6512:12c7:b0:512:bc14:6b80 with SMTP id
 p7-20020a05651212c700b00512bc146b80mr4458422lfg.25.1708464037152; Tue, 20 Feb
 2024 13:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
 <b428c48b-578c-46e2-a0b7-c648b012f3d3@linaro.org>
In-Reply-To: <b428c48b-578c-46e2-a0b7-c648b012f3d3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 21:20:26 +0000
Message-ID: <CAFEAcA8++iLJ+LMjN_GzoctdvA-+XraA1O1CSTGm3b62Do8JtQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 20 Feb 2024 at 19:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/20/24 06:06, Peter Maydell wrote:
> > +void resettable_container_add(ResettableContainer *rc, Object *obj)
> > +{
> > +    g_ptr_array_add(rc->children, obj);
> > +}
>
> Did you want to assert here that obj does in fact implement Resettable?

I guess that makes for a nicer detection of that class of bug,
so sure.

-- PMM

