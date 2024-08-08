Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AC6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 07:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sby2L-0001lM-69; Thu, 08 Aug 2024 03:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sby2K-0001fx-39
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:58:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sby2H-0008Ms-AZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:58:15 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso282737966b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723103890; x=1723708690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/jA7xNKwer5X7IcOleIJPAXaqZZOBhl5rPR2VUKiDHA=;
 b=u/Se9q5R8ZM30aRbCOrEhY16EweHxEzyI5Qf6xdN+e39uAl2KCpjsEAqnPEG8UlORB
 qMhW9pw9chIz3SpdfrZfNensdGLsG9eiVMAQd4JSBYZ/8pMXHZ4d0dkm2uFgZ1h0NL1k
 fYIt65zFh3eOTENgUqw4XIWxEatWuwXl+0fgwLMRvYsbAOQaRlwU0JFvCZa2qGzF3tjQ
 V+89RKk1eaBBhU8rp3/eshVijDNJGNhgZ1aKqtsktQTc2vR6UJygmCsBBq9/FfZa0geW
 PqmHkvOnHzAuO3CNX2GVc2AKyjwiQZNgVzkVATVG1FtJJEBAN7vtxfdzmfaznjygOYJM
 eEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723103890; x=1723708690;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/jA7xNKwer5X7IcOleIJPAXaqZZOBhl5rPR2VUKiDHA=;
 b=gmIYz7JzJypCm0Fr6Sa6ZCM3i3m2i7Mxp4kE/Skky1iI0BtwHHwck3XuBHzDh4DqsT
 r26HzEJsqHT4eLd4Ws6Fg2UgeBpRgXU8BGnwxk+I1kLzyVSrnNyoIbCO67zw2AUmrCtG
 /NVD/yChgIDMDdGWAf/OJNgrXqx4cW9JlR6lRbfvY1SPSs5iLUS8DlZs83tEA5LnKA/l
 N4s/Lkl2DSAQrXS7x2R3DUmcGaFzSKHAX/+z1n8NRNRpC5lZlxNUzK2UVq13/ZNqGdRF
 qvIIvls4BA6qt4wYPnWjTI1RPeIep1xiPooC4MmITMc8WW9fS+tjZu307dWZZZKhFLRX
 00uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXikhOMUaQ6x9lXO2/wgeEgl2eu35/+aiKNU1MQr3F1H4062lRHJH+UZj4oEyzbaXLIDq0gHR45Nj5YSuLOqVft36Urk8A=
X-Gm-Message-State: AOJu0Yx1fMooDX4qQQePMbJ/rmTujvbZOdYTua6zDOeIq2CK29q+ntd8
 gQ5k3JptVq6prk0rKvpLjQUoxQnx64YBdPYgVtYcXAjQqnc7omBymm63MT1tsi4=
X-Google-Smtp-Source: AGHT+IG/mDEjY6+3gPwg+sL4Gz8jp4PzP6hVZ5gSB+BMXwIWJDAPKzWNDV9yc1Pt2j0ecPkolgDFtw==
X-Received: by 2002:a17:907:c888:b0:a7d:89ac:9539 with SMTP id
 a640c23a62f3a-a8091ec7f4bmr73870666b.7.1723103890362; 
 Thu, 08 Aug 2024 00:58:10 -0700 (PDT)
Received: from meli-email.org (adsl-122.37.6.3.tellas.gr. [37.6.3.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3c6esm728230566b.15.2024.08.08.00.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 00:58:10 -0700 (PDT)
Date: Thu, 08 Aug 2024 10:49:35 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v6 0/5] rust-pl011-rfc-v6
User-Agent: meli 0.8.7
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <f989d834-706a-4708-be81-f6447237425e@redhat.com>
In-Reply-To: <f989d834-706a-4708-be81-f6447237425e@redhat.com>
Message-ID: <hw3gw.4cxgt9epvs2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Thu, 08 Aug 2024 09:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On 8/4/24 23:04, Manos Pitsidianakis wrote:
>> Changes
>> =======
>> 
>> - Setting MSRV to 1.77.0:
>>    * cstr crate MSRV is 1.64, which is more recent than Debian bookworm
>>      (1.63.0) <https://github.com/upsuper/cstr/blob/master/Cargo.toml>
>> 
>>    * pl011's dependencies (mostly proc-macro2) don't support 1.63.0
>
>proc-macro2 is listed as supporting 1.56.0, and in general I don't see 
>particularly high MSRVs for any of your dependencies.

The issue was with transitive deps, proc-macro-error crates etc stopped 
compiling when lowering the version, which means we'd have to patch the 
dependency's dependency to see if that'd work; otherwise, yes!

>
>cstr needs to use version 0.2.10 in order to work with Rust 1.63.0.
>
>As discussed on IRC, there are obvious advantages and disadvantages to 
>using meson.  The main disadvantage is the extra work when bumping the 
>version of the dependencies or when adding a new one.  The advantage is 
>more uniformity and less moving parts.  Overall, I think it's doable to 
>use it.  Dependencies will mostly be added in the early days of QEMU, 
>and won't be updated too often due to our MSRV constraints.
>
>The automatic Cargo.toml support in Meson is promising, but it doesn't 
>work right now when cross compiling build-time dependencies (which have 
>to use "native: true" or Meson rightly warns about mixing build-machine 
>and host-machine binaries).  So right now we'd have to write meson.build 
>by hand for those.
>
>My suggestion is however to name our manually-managed subprojects with 
>the same convention that is used by "method = cargo" in Meson 1.5.0+, 
>i.e. name-APIVER-rs:
>
>	arbitrary-int-1-rs.wrap
>	bilge-0.2-rs.wrap
>	bilge-impl-0.2-rs.wrap
>	either-1-rs.wrap
>	itertools-0.11-rs.wrap
>	proc-macro2-1-rs.wrap
>	proc-macro-error-1-rs.wrap
>	proc-macro-error-attr-1-rs.wrap
>	quote-1-rs.wrap
>	syn-2-rs.wrap
>	unicode-ident-1-rs.wrap
>
>and to access dependencies using meson.override_dependency() and 
>dependency(), instead of get_variable().  This at least reduces future 
>churn.

Yes that makes sense!

>
>As to the individual patches:
>
>- for patch 1, roughly the same changes I had made for cargo can be done 
>for rustc, so that the cross file contains the right --target option. 
>I'll reply to the individual patch.

That'd be great since I'm not familiar with how the cross file works.

>
>- for patch 2, the only issue is that you are specifying 
>--no-include-path-detection and that breaks for me on Fedora.  I have 
>not finished testing but it seems that it's enough to remove that line.

I had added that when trying to debug bindgen failing to find headers 
when dependencies were added (e.g. linux io_uring) or when compiling on 
macos, let's test again to see if it's indeed unnecessary!

>
>- for patches 4 and 5, I have minimal comments on the meson.build.  For 
>patch 5, however, I have already done the above renaming as part of 
>getting cross compilation to work.  We can synchronize on IRC on the 
>best way of getting the changes to you.
>

Sounds good to me.

Thanks,
Manos

