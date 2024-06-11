Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A50C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3hr-0002Rc-Rs; Tue, 11 Jun 2024 11:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3hf-0002IX-G8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:46:34 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3hd-00016r-Qp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:46:31 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so1608918e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120788; x=1718725588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8UK/FtA65YKrbi2OPWqWUPBzXV2pk2QyrR5PK0jmML8=;
 b=ovCvl1/RZZw6Bz7il/mrBjAvhVsuewVZ0pK4feR1Y+ARF5qeacBdpqrvQ/Em8VKWek
 9oWc2ExeUfzxWoj3ULiPSPERVrNkI2irEhzbyhHgSUNnTjxW78sL8YHd673aTCAKFdJd
 jCxmPR/rYKiTxXZE/cJkR6b/BQweorwt3TNmK4vov2llJGRxJPC5aPkBM2ikx4QHRVAu
 cciGSLW5aqvIaxASlTZlAngmqH9iJKSee5Hd/IQ2j1i7SwjybbUGakjbWpousXCoW4w5
 N8pWZL4ETx0mGrWMlJq6EbaPkBp8MMmQxd339q5ypdz37442RlxYyvqDlG3uhlENTu5E
 nBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120788; x=1718725588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8UK/FtA65YKrbi2OPWqWUPBzXV2pk2QyrR5PK0jmML8=;
 b=h/L2h0ZzUti2pmmo9XIOnUgUTXKwxXCA07eQPnfMSJJQpol3R+d3tlhClOPTg5C1QU
 oTo4BrHpVv98YpV4TnX8NL5zKVKbvqm75yk/t7kLA6ZW/fwCjdeyuB26gGwK1z3J5XKu
 jaJuvKF9gzt9F2ddtRTDNx4qiiABqY143KlSaHIsJOhUErOwtOZkXXPS4oXW9X4DkrRM
 IE3/LG4Fi7azmIuUP/GxqIgbMFSXLdmOzDxAGXQXZ7PGdKf8b+cRVVCJX20kvNtNdROK
 wMixwVxb96dRdZSu+L65IGNBiHydYd7XfotTHSjzXyYWgb5JAhtzkZoUU5Fs4c/vdBsU
 CMug==
X-Gm-Message-State: AOJu0YyWh+6ubdiyQ6A7X5K+F2pRqv6XpyKN5OUF5Jd2w+MS0UHO7oHX
 pgLZx2G7BbA7rGpzeguPWxUAOjs/IwChGBJp6V840INWL2uNqnubcSj0FafQb8PJa/RWS91vxkl
 /II0IFvaGX2FjrLLe9B5fFaTrrNeo+nn3kUeZPw==
X-Google-Smtp-Source: AGHT+IHBE60RQ01Tv0e2WwByDcisCFVSsJEWd1FOLpKSZ88xXke1iOlOKQDyK51i6NdWlt0WaOqoQghMIDQSU7Z6rjE=
X-Received: by 2002:ac2:490b:0:b0:51d:1c86:a274 with SMTP id
 2adb3069b0e04-52bb9f818ebmr6752513e87.34.1718120787939; Tue, 11 Jun 2024
 08:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-6-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20240607135310.46320-6-shameerali.kolothum.thodi@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:46:16 +0800
Message-ID: <CABQgh9EhUGNy+RDfrU0BLa56sMKELMckkTC0Ae91adg-LzyxGg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] migration/multifd: Add UADK based compression and
 decompression
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com, 
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com, 
 huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12f.google.com
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
> Uses UADK wd_do_comp_sync() API to (de)compress a normal page using
> hardware accelerator.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>

