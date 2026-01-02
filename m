Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982FCEEB57A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 06:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbYTv-0002Eu-8B; Fri, 02 Jan 2026 01:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbYTu-0002CV-4j
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 01:17:50 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbYTs-0000gm-Ld
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 01:17:49 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so9127771b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 22:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767334667; x=1767939467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OH57BgWfKgVcUjHcX2sslkPsvofA57BmULb87bgV1Pg=;
 b=yC2nh9kmm0Y57GKXa2a+qM424hCsCqfKAqH5UAK9pxEN/FbhAOfycdRphL9QZaVDs0
 priKiSm9kqzVrA/r10PXVdNI8QW4qyR4uXcK0Ib5H9/CkD7HSOUv/X7+epHfsJAVSHfx
 d54YjgOoqESPl4KyVSWK0cZVaVQg42B36duMwO1/Ov9CegY/ONQ/eZWnSJe5xkogu/5K
 +vrpLC1eKRNLTTp2kMhn+lA2hIKK5TcdOsp1EKUTLNu3fFqOogA+cBd3rHC5TN6+ZajU
 K+WRYaUU1LwLOR5U9oehsRLBCt6iGnTyic5dz+J5Pazxu1wamdMI0hmOLsHhtvdTp3rI
 PLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767334667; x=1767939467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OH57BgWfKgVcUjHcX2sslkPsvofA57BmULb87bgV1Pg=;
 b=mH/LgPMjLGMy6amWD1e/Y7F2Y2uocBu1XfVVw5pgTiQnc9Y26p2gvhheWf5DNoB/Lq
 4cdUe8djAth8WhlPg5tRiebw1F6HLNmYV8brIGaT5bUL6IognrlsKPtEysBSdyxOcCnc
 wx4f8bmd7pjZiMNtQJkGkVRX8FKAggWTdK5LBQv04kEiplILamiIevUqVXOQ2RNtxybf
 UiRYwXwn7HGwpJY1O1UZQK2V7RWnhpmb7nYA2eOdYFNjzgFv0a9IpXl90l/8GYlMG0Vz
 J88vTStKNUqpkRWbHQhsPTMILXLRU7OyuFr0/8Jb+EHvcDIAtzW/Ysj5kL0GD0w1UXFL
 ShnA==
X-Gm-Message-State: AOJu0YyqWf6gkPVdL+S75rcVQtmXYDxZXGw+l49pezqa64AnLRjck2BY
 s563pc3WgVuELKTWoyaHh1eyoGC8sTTd1fjlaOQNKrR3rDW22Sb/MWJVAdQY0cFI1DY=
X-Gm-Gg: AY/fxX437e8d5U+o0E/+AbdHjKSdIUUp/+E1yu46v0j7+JUvsD5j30/6g0SAn591RQA
 v4+POnehRgqCIQg8SKFjJ+F9HbPGZKKSx7k/pm4gSROLBhhLBEtFHqIi+6IX1IQcm+v9jjqNdQZ
 +H/Uuj6jF3P9FE5glKhZFXwoUCtXySTtP1ncAvsC11nBTeDS7bgvzmL8HhYLbxwrj3HR4LQmKa+
 Ui8xFwLpSGc0jUGeUiN65nn2xyesfYQYzK2tHiN5p2vy6YYecCuSnJpA+EDzqvg7qUjJL/ox6Uw
 2ZVLOFXTZ+yl6toR2JjGqOkEesFw7qQl6dy45k0dP+LKIUVZ6jnV5ss+SnY4bCHhgUeFLFYBUUn
 D23W8ROtKwnUQ+Q3hDOntZB2YVkssvcFf2FhZj7JVQzpHf0DI5ZhYWooQ5t9BPhhVEGdeqP9XEr
 W01SMO7lP+4qS45VivHrUGbakSGlVL14gQWobhsneeVfcZeqKRRIRSAh/f
X-Google-Smtp-Source: AGHT+IHb0Liaw89oDsrt4E7ySw9fwWCWW+JUZdoCtkOis5XSF6Z6dCm/3vOKwIFc+5OfMb+JNheVnw==
X-Received: by 2002:a05:6a00:3385:b0:7fb:c6ce:a85c with SMTP id
 d2e1a72fcca58-7ff6421226dmr39261809b3a.6.1767334666788; 
 Thu, 01 Jan 2026 22:17:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e892926sm39352413b3a.66.2026.01.01.22.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jan 2026 22:17:46 -0800 (PST)
Message-ID: <432294c6-01ce-48c9-8f5e-8df701b1c293@linaro.org>
Date: Thu, 1 Jan 2026 22:17:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] include: qemu/ctype.h -> qemu/qemu-ctype.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
 <CABgObfY1wpqryyBbf3tpCwZGT0izto_hda+izOUGZ57jwQzXMg@mail.gmail.com>
 <523e0a47-9076-45cb-bdc7-8310cbde0566@linaro.org>
 <CABgObfZqauCJHZOgaH01pCC7t-7pA70QihpALieXtEBRYe8RLQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfZqauCJHZOgaH01pCC7t-7pA70QihpALieXtEBRYe8RLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/1/26 9:11 PM, Paolo Bonzini wrote:
> 
> 
> Il ven 2 gen 2026, 06:01 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
> 
> 
>     Thinking about all this, a good solution could be to isolate
>     <qemu-plugin.h> in a new subfolder (include/plugins). This way, we make
>     sure plugins are properly isolated, and there won't be any conflict
>     with
>     existing ctype header, so this patch can be dropped.
> 
>     What do you think about this?
> 
> 
> That's exactly how I thought it already worked. :)
>

Ok, I'll migrate the header to a new cosy folder, and we should be good 
for this part!

Thanks

