Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0882CE835C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svIUU-0002Gi-6R; Mon, 30 Sep 2024 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1svIUS-0002Fz-No
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:39:12 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1svIUR-0007li-8v
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:39:12 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4a3af44dbc9so890519137.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727710749; x=1728315549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cf1HQtklgsaEeWile035rkJ7l/5wCk3aJxRghHt4WA0=;
 b=me3Q1N/tvE609Yg2o+o8t7h0NOjrMpUbWYgV0y35gmNtqSWfMMge610AeV273/BqOt
 25zUZ8CKo8g5fWxfJy2a42xNR3Xf1JB3QHx++QAh3LI4YLRROtQ8vL+OrKZud2vgDG/e
 XBGGv238MrY5oaK/goBDds2Qe+rc1bUqxvwyysW+SN1FO9KFlBy0VWaqypWI0Bd6EE68
 OgPl8lN3NJ9ubB0ENZ13UwpsUTiU/FTytppk4iGewnq76esvTQS2hNTxGfXT+81MxEhM
 Lm3U7/LiiYGxsROGwVubDNQGYcHeNPejOE6MlSVzdKHwFEJzNveNFhn3BnKm2MC3pzCK
 qt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727710749; x=1728315549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf1HQtklgsaEeWile035rkJ7l/5wCk3aJxRghHt4WA0=;
 b=nPuBk36fgYnExYQXK1Qht9ZNYtqnxB/M3rlfojiHVyYK5hKtiWosj0VPGQTym0mwRY
 o715vHm4Xn9GRzsd/vU67w2gqePPwbthMVEAuzwxLLMN4pOuTDKBbI5w0spZ6i/gVMNR
 gHzjDqaAnCm9UfOgkhv/xKctucofHQEIbdRpg6/xydiTJBKlSeQPZ5jaPWiMKEpemw0v
 pJME/Furnki5LvzSrb5FLA1Uv9c5SdYYME/BIoyP47Wqyi9VWvb0AWM0MIGdtitfGfs9
 Mjq6voQgeOTQqLnuNsw2Tvz4dT4q4Il6uOdJ5WuEA/ksWcw+exuSHFJ7PnB/NgmFJvRt
 9BXQ==
X-Gm-Message-State: AOJu0Yz2WwZlSW19X/yMUpvuT8Y/OMCymN/QAkTlsw5NavuB85yaT5Yn
 knOhT5iC42L5RjLzqxtx0r0K0ni7YSFwhXlYKayni/2I4e8zq1sx8BsG6fzZlkHiMATpUj4VClZ
 ylM7ddvXNXId6yFImLQNf5W0voLVAkl7A
X-Google-Smtp-Source: AGHT+IGps5sBjXjwSeApaypi2gkZxZTpZ5BV4OEaQhUq8ZwNTvMUnXj/xQLTHmQzjGmWpGybkprRoGs9gClxvoM74hw=
X-Received: by 2002:a05:6102:32cf:b0:4a3:d3d5:4447 with SMTP id
 ada2fe7eead31-4a3d3d561f6mr916847137.18.1727710749297; Mon, 30 Sep 2024
 08:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240922094441.23802-1-dorjoychy111@gmail.com>
In-Reply-To: <20240922094441.23802-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 30 Sep 2024 21:39:06 +0600
Message-ID: <CAFfO_h45rEpK8iHEiy=GV9D6Dk9Ex6d2ZOUqoV3+rA6a1EojXQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org, graf@amazon.com, mst@redhat.com
Cc: agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping

Requesting for review on this one.
v7 thread URL for convenience:
https://lore.kernel.org/qemu-devel/20240922094441.23802-1-dorjoychy111@gmail.com/T/#t
Thanks!

Regards,
Dorjoy

