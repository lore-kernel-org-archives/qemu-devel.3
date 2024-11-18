Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8CAD60CE7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 21:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD9hN-0008Db-6H; Mon, 18 Nov 2024 16:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD9hL-0008DD-EU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:54:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD9hJ-00034j-U3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:54:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cdbe608b3so46483725ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731966856; x=1732571656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5lc7SQzqb8FbPMx3RtPvky1mKBa1oSXjS7QGFAeW0Q=;
 b=OoczptckP38w0/xDjQfS3gR2pTzGAuE6e5pJBvS8AnU6WSRvpl+qy1ixR3Ylt7mzTq
 zJa+95Z7DhotwN/FaR+za2lYXZ7ER8irTdthSEgEZzrMaj8yCoj9GTL0i9lVpirXb5sY
 NfEnmk7dpXYQRGBbIz0yejLolbPt/K4G5o0L+HMo4A5P81k55UQm3vaIUSrbQbW+PPdE
 6F+4Ajo0jVXmqSBMoeNN+CUD3UoMMfH0emxDSb7edCpqhnhuSUPZHV+Scdms7oDV3Gwf
 MCeYkUi2xQw+9cfDp9tgy9uEAijo/dGrTZlEtNFIjS+6pXUQ8+d1ZX7hP2zDmH2CeDq2
 TNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731966856; x=1732571656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5lc7SQzqb8FbPMx3RtPvky1mKBa1oSXjS7QGFAeW0Q=;
 b=tnfylRxAgl5ucaHnAwOL6D6s9c9xeDZb+oJOkSiFP6+4w5rq1qs0Ag7RBXdFRvcqjY
 IQJGd9KrkM1nhaGp9rbaGpAPFQ+0RwiXb97pAC8KzywVUSkHXBIjnNm6aI58dgRCEzz9
 M/e63L7wJyYb5rL6r8o9t5FtTvF70L3DCpMrgxzjDh+FSgLIMTVKTq1/tuurbK4nch2/
 VATmcZ5rDjCyEuu3XFYygAutbgf3Q/RhowzDmKmNOeiIeTvVi7oks6FwqMegy9hWfjYq
 61SSaO8Ugmek4a1qeypYh0Hi4f33p9MnFVcSsmPMDHxcljBh1GKGE/U1ZTMScqvfx7pV
 9JSg==
X-Gm-Message-State: AOJu0YyEhgCgfv5sKPbqsv2KjdzMRCraTELIg/47TlFEotbTnSUbq8HJ
 EUWdFEGvrkdSrfYU/lQMB1h+vfT3Kn/13CS0wh74JrdNfvWDHqZA+RRwqB9eDxaP7E0jodB4ozL
 e60+hYQ==
X-Google-Smtp-Source: AGHT+IHBLHS0TaVACqKTLLNJ7v1gfdsdwRuSEgdVlRctxjHpENjaoOI5f2MoKicXmxAzTlsGI6IoNQ==
X-Received: by 2002:a17:903:2304:b0:212:675:c061 with SMTP id
 d9443c01a7336-2120675c326mr114994525ad.4.1731966855978; 
 Mon, 18 Nov 2024 13:54:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f346d7sm61012365ad.138.2024.11.18.13.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 13:54:15 -0800 (PST)
Message-ID: <012c4f94-e820-4bdf-a97a-c535e84c883b@linaro.org>
Date: Mon, 18 Nov 2024 13:54:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] plugins: generate list of symbols automatically
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 11/12/24 13:26, Pierrick Bouvier wrote:
> Now that meson build for plugins was merged, we can cleanup another part with
> the symbols file.
> It has to be kept in sync between the header (qemu-plugin.h) and the symbols
> file. This has proved to be error prone and tedious.
> 
> We solve this by generating this list from header directly using a python
> script. Dependencies are triggered correctly, and the file is regenerated if the
> header is modified, as expected.
> 
> v4:
> fix second patch to apply cleanly on master (was applied from a previous series
> to enable windows clang build before).
> 
> Pierrick Bouvier (3):
>    plugins: add missing export for qemu_plugin_num_vcpus
>    plugins: detect qemu plugin API symbols from header
>    plugins: eradicate qemu-plugins.symbols static file
> 
>   MAINTAINERS                    |  1 +
>   include/qemu/qemu-plugin.h     |  1 +
>   plugins/meson.build            | 12 +++++--
>   plugins/qemu-plugins.symbols   | 59 ----------------------------------
>   scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++
>   5 files changed, 56 insertions(+), 62 deletions(-)
>   delete mode 100644 plugins/qemu-plugins.symbols
>   create mode 100755 scripts/qemu-plugin-symbols.py
> 

Gentle ping, to hopefully merge this in 9.2.

