Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E3AC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkITr-0006eE-J4; Wed, 13 Mar 2024 02:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rkITk-0006do-Ep
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rkITh-0000oN-Pd
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710312761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RTsKUZX5IKpC422GXjPMiUTnpKW+/AR3Z6eYRgR/tTU=;
 b=QLUVIULs2iaed3B3p/7GU7YWQJgFZPJai1c9bRx5dqJMHkQcrNqhLksXurK+n/5RFmP66r
 blblJtq2hGcfO4D1rHMdnDOVDBc9PWFPPlAsUSoQ8NfbtAjYCI2JXhIcgUIJ0VjMJw9m/R
 wYn0+tv2s9f/uTDo3JZUbMnk9c/WvXM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-FZjjMAOZPdGMh1EvKam6ow-1; Wed, 13 Mar 2024 02:52:37 -0400
X-MC-Unique: FZjjMAOZPdGMh1EvKam6ow-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-568728e521bso1461805a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710312756; x=1710917556;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTsKUZX5IKpC422GXjPMiUTnpKW+/AR3Z6eYRgR/tTU=;
 b=aBCm2K1Vb2FNDhh3Ndxc/iRbj7DTUjRwaOvY5NbrV2s+Glcvlk3FBnflEfXr/Kz0+e
 zyzdIC2pLkur6ySNQ7wkwcx2asPE9WbtKTt+MeeIaW5N63WJNxhCnlXUDAhqwjxRXuLd
 BJsanCYyU8LImCyc0d90DReeasVPoclCt4vC0RhNTJDKWR2TZv/Bj+OO7u7DicXPe9pd
 OCwA6ovvC01E/p3srznSba77+ohGWPGufafS/CdtyzvJar2vejTzdcbeK7Hgx7rWyZtr
 U96ZaUH1fsb5+oUkONdb5OHiomSA3xeOcYUXDAZJKsZt/8+H1J7sOf6mvFtcQtw0Q8vZ
 OKog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqgJ3rJmKk9b2JnyLnjUh1v5FRKesC5N23hbLxDZoRkv8AiE6Nc+yZ22xFHZapxfQ5PnZ/emimethD74Lv3dssWl0qwKI=
X-Gm-Message-State: AOJu0Yypy6lrIwzg/8sYmvrBCOMJ1vcJhEHX7U246G9VrRhFjHoYBgbN
 q9zYrGZTTmESaAy5/YeODgSvKaP+FUJ5/7+mlC6RpR2o5Wf6xvcfzL6BrpFVvMxZHi9R0jlVnvv
 OaYjgPVPdcRk/fyfVJcp4HK7Qggo4qp6ylPrmFuY56Dcbbu/ZkDpyLUzeqQfo
X-Received: by 2002:a50:9517:0:b0:568:79cd:a857 with SMTP id
 u23-20020a509517000000b0056879cda857mr2256569eda.36.1710312756427; 
 Tue, 12 Mar 2024 23:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUdGgiYAerg/pj6xdh/1pt51dy0633RClLjBTMNKG+WIA1uMwy8KDPOG6hMMBEOeT+khNnDQ==
X-Received: by 2002:a50:9517:0:b0:568:79cd:a857 with SMTP id
 u23-20020a509517000000b0056879cda857mr2256564eda.36.1710312756113; 
 Tue, 12 Mar 2024 23:52:36 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm4757401edt.12.2024.03.12.23.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 23:52:35 -0700 (PDT)
Message-ID: <6a181966-1d7f-4d7a-9100-72555255e278@redhat.com>
Date: Wed, 13 Mar 2024 07:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
 <20240312183810.557768-2-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240312183810.557768-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/03/2024 19.38, Peter Maydell wrote:
> In test_rx() and test_tx() we allocate a GString *cmd_line
> but never free it. This is pretty harmless in a test case, but
> Coverity spotted it.
> 
> Resolves: Coverity CID 1507122
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/npcm7xx_emc-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/npcm7xx_emc-test.c b/tests/qtest/npcm7xx_emc-test.c
> index 63f6cadb5cc..2e1a1a6d702 100644
> --- a/tests/qtest/npcm7xx_emc-test.c
> +++ b/tests/qtest/npcm7xx_emc-test.c
> @@ -789,7 +789,7 @@ static void emc_test_ptle(QTestState *qts, const EMCModule *mod, int fd)
>   static void test_tx(gconstpointer test_data)
>   {
>       const TestData *td = test_data;
> -    GString *cmd_line = g_string_new("-machine quanta-gsj");
> +    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
>       int *test_sockets = packet_test_init(emc_module_index(td->module),
>                                            cmd_line);
>       QTestState *qts = qtest_init(cmd_line->str);
> @@ -814,7 +814,7 @@ static void test_tx(gconstpointer test_data)
>   static void test_rx(gconstpointer test_data)
>   {
>       const TestData *td = test_data;
> -    GString *cmd_line = g_string_new("-machine quanta-gsj");
> +    g_autoptr(GString) cmd_line = g_string_new("-machine quanta-gsj");
>       int *test_sockets = packet_test_init(emc_module_index(td->module),
>                                            cmd_line);
>       QTestState *qts = qtest_init(cmd_line->str);

Reviewed-by: Thomas Huth <thuth@redhat.com>



