Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0147DC54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rieiA-0007NE-CE; Fri, 08 Mar 2024 13:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riei7-0007Mu-Tr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riei6-0005r6-0Q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXbzKzH8PjEmvYnCpJCIgE6b32sSxREKUdx9WpH18Vs=;
 b=IUvergt9NnR29h5XnrkgOMKEApfbgBxJ5Au7GEZvSlerD4w2F2OAzvdAMtbDmUx9hJ07V7
 Ru+lAaom6LLHNVWqtBwPIdBtjHSMb3XI+uwTluIjnkCK4zg+lphc1glm8BsA/LsAOBeVHc
 mT87gVEGekfK2PPO6cf78l1wF11lVtE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-8l7F_5wLMzO8j6Zr5Ui22g-1; Fri, 08 Mar 2024 13:12:44 -0500
X-MC-Unique: 8l7F_5wLMzO8j6Zr5Ui22g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412db897ef8so16808665e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921562; x=1710526362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXbzKzH8PjEmvYnCpJCIgE6b32sSxREKUdx9WpH18Vs=;
 b=GkjkWF68I+z2ctDrUS8UD9jioRRJeULQ5lIED1cC24i7QV+pdaTWxntU7YVjOYv1HV
 IutO8UzzLWhKPjJGdbTIsO718nDw7vUCgdzYPW93AnwW47sphiDahs7Yvv9f4kQH8OMj
 khF8eq3vjFuyNk/1Lt3ey9KzlWOYqxuOOqJORcsUNyqhNnpmjGv+uAjocv4ZIItGsHz/
 IFOKmTIE3CuMTDtNLK7pmSQIhI5s7DxC9jFpf1/MOUkQY9Cu/l23RgjsCoW7IKLoduCV
 8pEb15vb8Cm1U4Mzo2o7dEtIEJDfUe62sv9LYsxXsZ/kwCCUwlzcoSf9UFmUhH9AjfWP
 iGWQ==
X-Gm-Message-State: AOJu0YwRwkPyx/CLvF3XOBE3/QtnwLOA3SPEFcx5oQcENBXKK2ECEc/g
 kQjK5a9/3atbVLDxm8tLFWQwlU6iVGwL95mbeoAnNsOeZ7yNmKY/8OIb2CnQrm536r5JtLFQeyZ
 QWWcjY54uRvAIYr5y1nzrNzQgzDivGnEq1mpeq++ftog6f6sKmqpKvqqJ+Ft6ohkfhiG6RwiQMW
 kf/YTZJH1NGm4WntIvyWQZrEMIm0FA0ktNiiw=
X-Received: by 2002:a5d:56cf:0:b0:33e:6962:fe44 with SMTP id
 m15-20020a5d56cf000000b0033e6962fe44mr1020553wrw.27.1709921562100; 
 Fri, 08 Mar 2024 10:12:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMZWvzeZN4ik7yIoTJwEUvrkhyKYJUWmJlAjc3Bd181+H3bKzh3ZYldQMiTZVVgslZQLYD/neAbREsd8yneoI=
X-Received: by 2002:a5d:56cf:0:b0:33e:6962:fe44 with SMTP id
 m15-20020a5d56cf000000b0033e6962fe44mr1020543wrw.27.1709921561911; Fri, 08
 Mar 2024 10:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20240308145554.599614-1-pbonzini@redhat.com>
 <CAFEAcA-7N+tOGPcTiR2wUGcE6c_KPnbGPV+YpY-qcQGd2Q8qYA@mail.gmail.com>
In-Reply-To: <CAFEAcA-7N+tOGPcTiR2wUGcE6c_KPnbGPV+YpY-qcQGd2Q8qYA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Mar 2024 19:12:30 +0100
Message-ID: <CABgObfatkZD1CMsB4_4AJKJ54NriS_Bxc5DM5OLiCapXN18ceQ@mail.gmail.com>
Subject: Re: [PULL 00/12] Misc fixes, i386 TSTEQ/TSTNE,
 coverity CI for 2024-03-08
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Mar 8, 2024 at 6:32=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> Looks like this hits a TCG assertion on aarch64 host:
> https://gitlab.com/qemu-project/qemu/-/jobs/6353434430

Ok, I dropped the TSTEQ/TSTNE patches.

Paolo


