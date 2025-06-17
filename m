Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81900C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYdQ-0006XT-Fi; Tue, 17 Jun 2025 11:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRYLN-00015x-V9
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:27 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRVZl-0002ZP-Lx
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 08:38:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so5188948a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750163883; x=1750768683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uKzW3H/dOr6s+S6VOJ2FYNtxIwtCXlSB+0Kwmd0Wjw=;
 b=nV1VHGF+NbmY+eth/eiEzQceA6f4DoDR0coEVAQYMDoGRrwrpQayVccvAVDtXPzMQ3
 css+WKemqmgFn85j7YCDlxzSUxpqoHfNTdZH5GSNfoApUm0z/nlgJHx1Gtdnav8lCBG3
 5sakoCepWpLProrK5Ui5AUgUHg3Mdlr8gWCujaNLPf3gAbDGqbK4/ezFoD9HWjfMcDyf
 O5dOjERWNnF+8AkJ+d/kb3ShPdl7NxAJn9LtsxIq/1adPpV1pc/eGgmJnZtpMMHRwb7R
 6lONPLHCG5Gu/t6w63vsLaBz+DqWDVZseINQciieeOMEuvmrno3oLtGQS9lRH0GDK4Dt
 vLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750163883; x=1750768683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uKzW3H/dOr6s+S6VOJ2FYNtxIwtCXlSB+0Kwmd0Wjw=;
 b=QeEq5dCS6xEv7VnPKZCHT2lQvI9F/XbfKKsp+lnzLWoBvMKf/dG20hqy6kdJQWi0Gy
 TilQNztdZqAyzydqRFHSk2y8fjTeAXzdS9DIyvwyalAvmcSG2PvK7NN/pBMUknWxWPAQ
 4DsEAkoYsi+E8OUEMogP2JVXWWj2FgC7OwzP85+a6Kv68hlE9Eq3bJmiq9y9i2Eqds+O
 /NiI4OuTxKUxMLK20P3QQQ/ffwFQe7l6lNanY12hNcJu1qFz5v5FHEkuCSjFfEzFzIKn
 zjxIev8AxqtdEoTwqse6fQhT1Hh9+tsEkN3H6lsFq7I5b0CnUQ7Kv5XsdbIJm/WqOARu
 o8DQ==
X-Gm-Message-State: AOJu0YwU2cGmtmUo1Dm0tm6dQ5huotTIC2xohNBcrZSICSbQBTBTe4ss
 +wBQS/mQKMygp3b+X71EiWKVJVOn/u4fo6HCBWlHt6Z/6Ir7gCgX94wARcv2WTw9Q8g=
X-Gm-Gg: ASbGncvXT6ePS9yBMZykzOQwBvQ9jO7E38gIHX2oJgwH6qVIPWH/3XjRM718fWT4xXc
 6Y5vLER1DiYNF8FeNc19FH6UzPROKA/XTcH8UzobXG2lXu7s7AG8tBtat5InS5ufp/R+1Vqs3b3
 kQueJL29xHgN7QQJjuRkSCCb4A19w7gH7ny5p9XTohPwDa8krxr8lLlz8mGtd+jJw2tQZuqWqCG
 Tah+v+BgNgHE4NCJ8qcFsGVc5hQ0zsrtzmHm1SL5OxSHglKBOmsS+drXkbFCvcMVElH4t1NZNBb
 c0F6p2vKYkqau62RSMcWhTfZ2lIkE2aneBO/AcVsdtweO2x7eLtc50sudzYT+soWI4k9WXC1asR
 LHnUTg9Yx
X-Google-Smtp-Source: AGHT+IGC6RdtkCaWoXRvoNEfspcD7NZpIqPCHsc0FaiMQf5DkPfr9+V3eIMMeGn+yh1WyjRj9mKPxw==
X-Received: by 2002:a05:6a21:328c:b0:21f:7430:148a with SMTP id
 adf61e73a8af0-21fbd57d24amr20201895637.28.1750163883360; 
 Tue, 17 Jun 2025 05:38:03 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1680408sm8773000a12.39.2025.06.17.05.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 05:38:02 -0700 (PDT)
Message-ID: <bbffdac9-a957-41d9-b1f8-3824e794831c@linaro.org>
Date: Tue, 17 Jun 2025 09:37:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tests/functional: Add PCI hotplug test for aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, thuth@redhat.com,
 eric.auger@redhat.com, berrange@redhat.com
References: <20250528203137.1654964-1-gustavo.romero@linaro.org>
 <87msa6vgsu.fsf@draig.linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <87msa6vgsu.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alex,

On 6/17/25 06:49, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64.
> 
> Queued to testing/next, thanks.

Thanks a lot!


Cheers,
Gustavo


