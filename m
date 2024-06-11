Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9265EC27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3jI-0004LA-3A; Tue, 11 Jun 2024 11:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3jF-0004Ki-Dd
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:48:10 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1sH3jD-0001Ss-Gp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:48:08 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52c7f7fdd24so1611148e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718120885; x=1718725685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m936C4I0IMR3Eb3vomVcqxpbQBOe3OrFPXcUMLrlZRA=;
 b=qWSAgHi7l8IwShIpksITm0FDtLyxHwBO0T4WPH9n3IEvjBhnamv6TjEN7YE5xx7SWA
 vG6+W/9dU5hEziF1PTS1+UXyYQg78LCw2AKyCvzqh2Ow9S3WS4Rxy1alzR0T0UxvcYWn
 iAGjCV2fila+gUowM2W9wr4QspkPTrch4FFWD0T0QLkSBDPndyp+eaU5pFJvUxa3Gzt7
 L6gg1mVnOGZUbw0BfUIMsCJTbTv0vgq6J0kRzXnqEMeSP6sLOWHgbNe4a4HGZKmDIjwm
 ifmCQv+wbk8s9rXqHeRd3QVPDVcl4nlvtdYQnUus5O0kU4eKfktsMQ9bS68bOkF8wHBY
 NrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718120885; x=1718725685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m936C4I0IMR3Eb3vomVcqxpbQBOe3OrFPXcUMLrlZRA=;
 b=BrR3OWKCxAmwYMvVeTqCysv8+/RyTEEbqlr9hqssQMjQjXRPus48O28dVRnwxG06uS
 opVDMjVwZ3vFRLocMRj3R6NfvGTJLhuTo0z6gWGDnWnZykqO3xZ5yWGDs5ZbFduZRV8n
 aLpzGVxdmO55PXr+nX82PPIYkina1G20B0XJDG3CZoKhQ+qFMhzG/DG2bwSi20T4fhYt
 Ghy291AHo9WjrGzqP+eoJHSGevAsX2qs/4bdDrTSAw05nGNiI1LKVavkp2An+7HmC8lJ
 Vmtybjci1pIHq+I4U7jakNUBIxAhMSqFnwzu3Lo96zWrr9Y+82hf2FzBuJCy9vhA9piM
 908Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4qf7OTarHRbXJudlIvLbomRJigRzgxmsSG4TO6VV5Z49b5Gni+ql8Tjt8o5XVCAJcIySTAnaC5Pn3KJ9Y5fonieQNebw=
X-Gm-Message-State: AOJu0YzqK5BliYksaHZzcJt4URsHZ3wxLmWZlJT4f6Tv0UdXzFSfWyJh
 gL8GDZlUJHKrDm8TP21iCRpXmBDUMK7l+/hWZrfZIYpwsD2D0OTjLbzgJZWJ+rnYwyn1XpBQ2Fh
 T56flTRC8CMWTuWSBJ69YcyNH2XaJ0ZDIQVFoHQ==
X-Google-Smtp-Source: AGHT+IEF1v91AT7EehdBIcAD5J105KNpkyWUh7DgwHp9eaxvl+MbOJj2Z+JkF2Cl2KY2kyrBloDqQzS1U5ZJZFM0xik=
X-Received: by 2002:a05:6512:3c96:b0:52c:859f:f4f0 with SMTP id
 2adb3069b0e04-52c859ff687mr5265097e87.1.1718120885504; Tue, 11 Jun 2024
 08:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-5-shameerali.kolothum.thodi@huawei.com>
 <87o788wsr8.fsf@suse.de>
In-Reply-To: <87o788wsr8.fsf@suse.de>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 11 Jun 2024 23:47:54 +0800
Message-ID: <CABQgh9GZyKBy99OHwhk6Y8zboDFSsFubLmx_Vw_NOqOdvEsYOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] migration/multifd: Add UADK initialization
To: Fabiano Rosas <farosas@suse.de>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, 
 peterx@redhat.com, yuan1.liu@intel.com, pbonzini@redhat.com, 
 berrange@redhat.com, marcandre.lureau@redhat.com, thuth@redhat.com, 
 armbru@redhat.com, lvivier@redhat.com, linuxarm@huawei.com, 
 linwenkai6@hisilicon.com, huangchenghai2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12c.google.com
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

On Tue, 11 Jun 2024 at 02:35, Fabiano Rosas <farosas@suse.de> wrote:
>
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
>
> > Initialize UADK session and allocate buffers required. The actual
> > compression/decompression will only be done in a subsequent patch.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>

