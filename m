Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0372DC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNJ4-0002qK-2d; Mon, 29 Jan 2024 03:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUNJ1-0002pj-UF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUNIz-0006WW-H0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706518068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cNFuZ06yct7zXlUPYDeFUQxAHd4f6+BSOwYlzuWZrs=;
 b=UPFIzGBXfHR371r+ChwmRMWg1dBA7uqOcMj0oTroCfgb2MTajcBfzHG7FHrRPEB6o6n2hX
 3DiV3RoTdBiEbvzyuY5BV2XlncCEjbjk0aLPlXeyr544kCfKGoM+VtKO7UeyNQE01UaHLA
 4nRz8Fg66mo7sqTDOcKQh/gTueJV3Cs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-NTbfg5QjNe23ryQLSQhvDw-1; Mon, 29 Jan 2024 03:47:45 -0500
X-MC-Unique: NTbfg5QjNe23ryQLSQhvDw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so555229a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706518065; x=1707122865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cNFuZ06yct7zXlUPYDeFUQxAHd4f6+BSOwYlzuWZrs=;
 b=cgyNA1eb/Jm83yPwlxT6lkeuOasBCotX92SLXh9HS2eOMubJVVHJnMa6lccVXjfOUq
 t5fOpyXfcyevgLlMqIMb+ek/jcZHDOmWuAVmrmKtIcKwOsTmSQHGtVokHXjYOvY5ztar
 S0X0QXxAMNjCSyQs8U57591b7oLKy4T8zO5R0tLk7t+TQmbm1X1G1mcOUp8P90/p33Lv
 LbSp8c0PiPH21hk4g77cNEBv9VmbaHjBvMs7vzPXiKmD6nqnbQVSTF0os+NSE9xk4cuy
 GmoBk/JPgwkReETTxYozW3O4YFVVJJ6vITmFNQ2+W8txENi1PUwKwiFcxU5A095e4uxE
 lPzg==
X-Gm-Message-State: AOJu0YzZiT9P0GnHXpM14Ktw1gdLYH1HYkFttrLQjyyove76fRRGbjDs
 K3eabFRJ4/PpxzIkHX5jNnPpOahwBzJJcYKcuvfH6EVXvY4D2fy8HrtbyFCXYSLUbyhcjsb9Woq
 HA+oZWgDgsCgvzPQP7QAEr+hEUXUbqq3X581tjIxW18U170bKDQ/C
X-Received: by 2002:aa7:9807:0:b0:6dd:86b1:7d93 with SMTP id
 e7-20020aa79807000000b006dd86b17d93mr6634076pfl.0.1706518064861; 
 Mon, 29 Jan 2024 00:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI1NRzNomkXVz1Rw+PQCS53C6ytX+rf1//kluWFVsUwua1xbB2y9cGqp1GfgtuuN5RmKgwOw==
X-Received: by 2002:aa7:9807:0:b0:6dd:86b1:7d93 with SMTP id
 e7-20020aa79807000000b006dd86b17d93mr6634063pfl.0.1706518064551; 
 Mon, 29 Jan 2024 00:47:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h21-20020a056a00219500b006dd8985e7c6sm5303444pfi.1.2024.01.29.00.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 00:47:44 -0800 (PST)
Date: Mon, 29 Jan 2024 16:47:35 +0800
From: Peter Xu <peterx@redhat.com>
To: Bryan Zhang <bryan.zhang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 quintela@redhat.com, peter.maydell@linaro.org, hao.xiang@bytedance.com
Subject: Re: [PATCH 5/5] migration: Add integration test for 'qatzip'
 compression method
Message-ID: <ZbdmJ3CnBft_g9qI@x1n>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-6-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231231205804.2366509-6-bryan.zhang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Dec 31, 2023 at 08:58:04PM +0000, Bryan Zhang wrote:
> Adds an integration test for 'qatzip'.

Please use "tests" as prefix of this patch.  It can be "tests/migration:",
"tests/migration-test:", etc.

> 
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

>  test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
> @@ -3480,6 +3504,19 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/multifd/tcp/plain/zstd",
>                     test_multifd_tcp_zstd);
>  #endif
> +#ifdef CONFIG_QATZIP
> +    /*
> +     * Use QATzip's qzInit() function as a runtime hardware check.
> +     * Ideally there might be a cleaner way to probe for the presence of QAT.
> +     */
> +    QzSession_T sess;
> +    memset(&sess, 0, sizeof(QzSession_T));
> +    if (qzInit(&sess, 0) == QZ_OK) {

Does "0" means it'll fail if no hardware is available, no matter whether
due to processor too old, or limited resources?

Would it make sense to test it even if only software fallbacks are
available?  IIUC the migration path will still be covered in software
fallbacks, so it may still makes sense to me.  It can be very likely that
most CIs will not cover the qatzip paths otherwise, because of either no
control over hardwares, or limited privileges of the CI user (does qat HWs
need special privilege normally?  I have no idea how QAT resource
management is done if there're only limited HW resources).

Besides, I believe all the data points you provided in the cover letter are
collected with 2 QAT HWs enabled?  I'm curious how's the performance of the
software fallback of qatzip comparing to existing algorithm: iiuc zstd is
mostly always preferred if sololy comparing to zlib?  where does qatzip
soft-mode stand in the picture?

Thanks,

-- 
Peter Xu


