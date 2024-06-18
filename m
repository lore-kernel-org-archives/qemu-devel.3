Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F68C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWG9-00054n-5J; Tue, 18 Jun 2024 06:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWG7-00054R-PP
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:40:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWG6-0007f6-6W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:40:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42108856c33so38778495e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718707212; x=1719312012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2is7xyEYuqiEZgV6QXi3BtDEMwISToweZ2YR4WbTaUY=;
 b=yA9IxOmxUOEDUcJGxxI5oGueH6PlOajnbEmQxLjtYrrtCE+qPRZUHVk4BSoCWZQ+2S
 iGkI9ujuOe6EqrTb0Q+MFKLJr5td0sJ7WhTwQWmC9e8+CSL+LqLsNFGM0yWiI4/c8P/8
 wsT0aXMCY4MEZU9IHz3eg8ltzpnSgxjTnEuOgN3W1IM52QppIf+hpYUQzL7n35H+2oXm
 prX8fz0hmEIEWFj/el5CKr+WsPDHlcpWAkJN752XSCyAiPIAuUzfQY358ySAhiozE1iP
 FhXOO8+fUdKiOJABSVwKTg5oH3eD9FArrYf6Lm9hyaLaaTSJraorvFoHv79ljFRRRU26
 yq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718707212; x=1719312012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2is7xyEYuqiEZgV6QXi3BtDEMwISToweZ2YR4WbTaUY=;
 b=xFjgqmi05/lBBB5ySoQjbjiBGVwlzdOmf38NZ7SGP+0chGtOP4HRKlECniDU6FSfqi
 RBoCna7ZnIREkcBDYYhAymEWNlkX7w7IoSV/eM9yPznqgN1Ul9vO87HLXgwd35pNtdq6
 HrJkCjJP7hCZme9iiHwHvP8dQLQ0y3dk0+cUxhQdcW5zmrqmARsK4uiyNkMownkSaOHc
 ajGhsu6lsknphMne9jgTcNTP/ybSHRi3wRSS2UyldXqVa15B7Do/fuzSMUWamecln+OF
 equ/N9eIt9R8iLb5kU8C6s8jSjm9TemEK+wyoonl2ANcx5+7asp8iqYEU6zywE+BCZtC
 4FVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBV9jUjXRcxnc2g4AB7fKzXj69G7kFkiRS0QOWsAW0eEXiPOB7VY8D1TkcI5opIjg/Et+g+WHTuoGRD1JvbPYZhp7/Dck=
X-Gm-Message-State: AOJu0YxloXaaKpc5+Vm3HdniYubCn3dx6GHnw9AfBCFe4ilaCJ9QW0sd
 2AHMhSE257P3EjscP/qhBL+EgIT+oMpUJl77evPIhKOM3/QIcjYB21u+fDvyJ7NQ/VX6oNPIIQe
 aSa4=
X-Google-Smtp-Source: AGHT+IFQgH+wTg/0kd3UgCIGPx7vat2VEDY7YeMW94oFY7LlqlDYiY6gM+9Qfu1fsXv4BfZyiKqlaw==
X-Received: by 2002:a05:600c:19d3:b0:421:4b0a:5006 with SMTP id
 5b1f17b1804b1-4246f581ce7mr20300815e9.7.1718707212347; 
 Tue, 18 Jun 2024 03:40:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33bdasm187117275e9.8.2024.06.18.03.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:40:11 -0700 (PDT)
Message-ID: <b7b92f95-0fa0-4f0c-8796-04617efea991@linaro.org>
Date: Tue, 18 Jun 2024 12:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] util/readline.c: Add common but missing shortcuts
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/6/24 10:06, Manos Pitsidianakis wrote:
> Some commonly used readline shortcuts are missing from our
> implementation. This series adds:
> 
> - Control-n next line, same as Down arrow key
> - Control-p previous line, same as Up arrow key
> - Control-u erase line starting from cursor
> 
> Manos Pitsidianakis (3):
>    util/readline.c:fix lints for readline_handle_byte
>    util/readline.c: add C-n, C-p shortcuts
>    util/readline.c: add C-u shortcut

Series queued, thanks.


