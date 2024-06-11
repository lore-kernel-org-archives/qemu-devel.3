Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE86C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3h4-0001Rx-Dt; Tue, 11 Jun 2024 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3h1-0001Go-QQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:45:51 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3gy-0000xI-Q0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:45:51 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c94cf4c9bso1042517e87.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120745; x=1718725545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyOskVIS9bynhII57TPWgQPgpXUuAr7uvb5ESZIg90c=;
 b=kKvj0WDVBkpwCbzWjcRAgdmY3mUiWVDgSsqbSu/6DjP7AsTWU/XmOF+31V9jJfL9fi
 t2JvgyNlUG+f0GGVNf+gZypE6irBSeeTjDIvE1SlWZWQLcXnE1tYhzpccF/t348JcMHp
 +8YYwR0zSwQUcbeZMecDh03yDcSbYSmYvvHmug0s23dnT3ETqKXLr/BDCyGMbE+bMvMe
 Li0UsDIjaD/nNa819GtelmTJvyEX0kfRfpz/FJm9rjbI0Hn3bQyetzXWTKy6YBZJ/VpY
 FO2Q70C0T+rGHx6kyNX/dqD/Y2UUPzvgrJJC1GraIW6OJWrDoLD1ETN90ZkmUqyx0bg4
 Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120745; x=1718725545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyOskVIS9bynhII57TPWgQPgpXUuAr7uvb5ESZIg90c=;
 b=N8At6HTIEa1M3mYEzkwsb9zFOPewu/4MNlJVwC3c7fCKbrfoMsEn4WL/HECO1FDUXf
 eEOZVl4y8qjjzQVh0+hjlFNf5XYuQyY67iI+hQl3htYmVQpeaYQHlfQkhVd+znAkOZk4
 j0bXd+1bhvo5ThUgl17CUZ4kOYlmGCZYErcSxpcWlps6skQ2FsucUMYS7oZSLAq4NQRD
 Fx1zUjNTB7Ls065Aea+skZaWkviouQaYw42mbLe1iSpWbXOqwbK4YcS5lJ789zttGKxn
 GTzqx5eS7DsR75S9HSq+fsYq3owxrvU0QXnV/USOz6U9Oiv6A1gbmWJmZH/moO4gvtK1
 7ynw==
X-Gm-Message-State: AOJu0YyrZ+z8mwMT7xidpTmskvYKFYBXdmpKaLEDdhywPDi6OMPQabcU
 kpobJRuCWYOpVU0Ig/qYHxaxx9ma/nyErR7s7jTp22IK4RIom9PH+l2LX1cnzaNa7lklhbhfhpv
 1YQf3Il7/OhV/iTPnMqE8KWi9N7WeopJPWStAOg==
X-Google-Smtp-Source: AGHT+IGEvk21NLz15DrxImn9teWGnYwEwaVDkX1BL2rI3C7jyWWlmeqsQsUxzTu8kaQq3oX2CvT0m0rjHMzdTI8Xm6Y=
X-Received: by 2002:a05:6512:3e01:b0:520:ed4e:2203 with SMTP id
 2adb3069b0e04-52bb9f64915mr13614343e87.8.1718120745482; Tue, 11 Jun 2024
 08:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240607135310.46320-4-shameerali.kolothum.thodi@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:45:34 +0800
Message-ID: <CABQgh9Gj48QqF=OjG2oQDWk2-DMu+W9Xvc60ckW9c57Ldmqe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] migration/multifd: add uadk compression framework
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com, 
 huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x134.google.com
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

On Fri, 7 Jun 2024 at 21:54, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Adds the skeleton to support uadk compression method.
> Complete functionality will be added in subsequent patches.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>

