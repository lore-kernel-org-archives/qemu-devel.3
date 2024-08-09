Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34639C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scL9M-0000w5-50; Fri, 09 Aug 2024 04:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL9I-0000op-LY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:39:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL9G-0001g5-HG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:39:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso13295405e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723192737; x=1723797537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i40+FZbye/QjWVjwUsmunMSfPmyHbl9qBPxkN9Yo86E=;
 b=MgfZtdmwM1yhJfsI5ob5ODu4WcXi/Z9yWZlT5HrmqHnZjH5+XGgzLLv/gAJQLdDwFz
 pO3ostBSC1neP1m21IZOfHOBDLNo6hQviTvdhghXRGDbUjypAOM+AiZcQSQAZ6JAIG5n
 f2OoATNAlSWvQt78UZ4uVJpRjv6tmKDrrfrPyB/oclQ1+YU5nf6fW/5gorI+oylym5+T
 3/piDfad2QSQw9ALv5F4iuz/6iDw96GIa6eiMO3+Vvq9XmqC5gXy6j6/fatlTaP4v7b9
 G38n4yEbNmCYkOJOiisyBeb2lpL7c051LqgLu6RosogC1ueJQleD+K140sdnEUsGvOdF
 4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723192737; x=1723797537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i40+FZbye/QjWVjwUsmunMSfPmyHbl9qBPxkN9Yo86E=;
 b=vnqi6TigmgH74GAAdJosukycUusw+JGVvUGNxxnPOUcydLnymczBu9KQH51l06rqt/
 mjddQ8bM2KUVisarxdNFQ8nBbm4JDgq+S9pfg2u+7TLwlpEW7yY88ZKHmvLsmIt4I0T4
 51ZCsaxgQ4XL2TjY5ve1jvS5bq9YOlKbCqFQKbzLqvqJg7xcSZF3duC1pujI9xxRibwt
 LtrihfXEyCMopIPFL9Ltlwrav0oRNVZ5e+aPlgWEgPt9HJdPtVdFPgcDJMSOvPFRBq6E
 QV3j1c750MDkgr5qbf5Sa461kyYLJvFW2rlkYxP+QVt7B0+6Y/ZNqxYX5d0Yo0DL34a5
 PgAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsBT/VNOx1qYTLQeSCQOJVcw21egSGdIqEKPHofP+1tfqLxLxJmAyZ/STL4ZluUYdOSuUCEy/aKMm1+44xok3y33njdUk=
X-Gm-Message-State: AOJu0YyIC379mG5yRpIQDuOQfrGqCV/TiYde0ctxgktf7crS9l9aLwjO
 HlBHfbmRm9qjqd6GgjQdyIMQJ0tTwr67jy8ypCh0fZeoVDTKOAl3T4oe/PAi5dk=
X-Google-Smtp-Source: AGHT+IFqMmK+LPpGHd6WlbRf72n1dluEyzb7IdbyyAimzjQDUHkOt/wmV0108Wmx4USpjPxl1/Gn5Q==
X-Received: by 2002:a05:600c:5491:b0:428:2433:1a07 with SMTP id
 5b1f17b1804b1-429c3a5b3b6mr5467705e9.34.1723192736736; 
 Fri, 09 Aug 2024 01:38:56 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42905971ad7sm116869355e9.17.2024.08.09.01.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:38:56 -0700 (PDT)
Message-ID: <a81f8168-6ee0-4a1b-8940-3822310f8fed@linaro.org>
Date: Fri, 9 Aug 2024 10:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] qapi/common: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808182636.3657537-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 8/8/24 20:26, Markus Armbruster wrote:
> Since we neglect to document the members of GrabToggleKeys, their
> description in the QEMU QMP Reference manual is "Not documented".  Fix
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/common.json | 14 +++++++++++++-
>   qapi/pragma.json |  1 -
>   2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


