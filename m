Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C8C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgja-0003em-FA; Sun, 04 May 2025 17:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgjZ-0003eI-DU
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:18:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgjY-0000dC-0t
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:18:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so3056532b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746393526; x=1746998326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwGqxM1zrCekJUHWXBxBL9XBh5wdHWA5bS5tebNHwcA=;
 b=V/aBuQuRd6v1yrxhDnPk6bm8QevrEOwO3kW5tsrvoU/J+ntGz+Cx9+zzeldsS3UYmq
 wyjDioXNKFjSbMpxL4vdGCraAEGwehC+FFAsayuNktNMP7zIInp4w81xsia1FOP+XUGh
 N8bpUssBmH4tcl99bfvvIWR+CUUo6/6laV1Aefmk8by6W4vP4Rli6peDge8/YLSsYsy3
 otK1vh6SNk2UZ1mTeD5VrP4SCJpPffhBOxVIaWx/qoR0JX4wn/CbImFiA3bh7ixELz29
 eaRdqTZMrwTE0eOL9eU3Bhpq5Vb3TXqQbvzCLfzIlGv2p89ZWpXQJD+neYwnH+c/iX1X
 oHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393526; x=1746998326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwGqxM1zrCekJUHWXBxBL9XBh5wdHWA5bS5tebNHwcA=;
 b=j2ywGyZz0jxVZ4xN0Q7gkP+N5hsGLsUdVEzf6BI7RMonicwQKJzPlj/Lnd+MImn3Dt
 vhfMEnLvAypiyyroQlmHMSRDsIy9BpWD7vpbE8ZEw8TZ9lavzWPHgZ9r/kDtbB5OD2WZ
 WXDNV3vlUvfiRRwvsgzsQVbPjrCH7sF2EBNETHEFQ3Hl99QemglFJR1/pAwpBxQ+U6+V
 hViotadHS2XCRDKJ1TUunzASqEw4/Izbte2UOd2QQ5JZ3FT3d37oyzhadkbQXXisA/RT
 +/WJIwEOvV12wcl83OiywTNFE0wVnFJfUXR7ysComJMUERZt9RJYOaR3m0/7qqTwksnH
 znNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEWySVUEyNcoI5CnVN3NVeOS1zxFf+wNzXlqQXwBNZbhaq6vzcW95u6qNJg/fmdFmTnrkdlQs6LZcc@nongnu.org
X-Gm-Message-State: AOJu0YyyT/+PTllkfb64x8zLamwBCNqWyd4ivCO5+6wLL7NY6kQb5uR6
 4qg9osB4TSIZ6wahJauNQGPc4OWedQzxMSyptwh6YfgVtlDWPgszmFOF1BX8yyc=
X-Gm-Gg: ASbGncv0t/fDYwPP8KaiqB37iXcLMkKlak9Z9SPCIrywRXkWLs+HJFoqwOhFtnuTBSp
 BMVO1y0LkbJCvfakMYZghwtwrYR7j5JQN6raL+afTZxGVcdgkbHnfPavQJnpEijFq2PlmSuUcOr
 Dqjm4nDY0qrgjgYBjXEUfew8P1t2VWVdIjbhRL1ni2XDP2u5MLkVNQPBdXTOHAaISERkSY5UX3B
 5w5Wj7yhSp23jnp3PBO4VvDFYJJzAVGekNx68CO7kCNxkUCePzbKelxm1kTQqR7TX2RkZsOG/s3
 R8ra2we57tmRBMJKdfQIb9DNp26UWS4CjHdVnjadmQh4LBfZkZHKQw==
X-Google-Smtp-Source: AGHT+IFnxYGUurfRKTjzm5z/HWx3eivO8tj4XXSxswPkNxcdRD9YcvGm1U1PTCo9YgRLopNT7zFy+g==
X-Received: by 2002:aa7:9314:0:b0:73e:30dd:d14b with SMTP id
 d2e1a72fcca58-7406f1769e2mr6609054b3a.15.1746393526602; 
 Sun, 04 May 2025 14:18:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7aea7sm5319259b3a.8.2025.05.04.14.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 14:18:46 -0700 (PDT)
Message-ID: <0947f801-1371-41f5-859e-e5ff427e3ee8@linaro.org>
Date: Sun, 4 May 2025 14:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hw/virtio: Compile virtio-mem.c once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250502214551.80401-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/2/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> Remove unused "system/ram_addr.h" header. This file doesn't
> use any target specific definitions anymore, compile it once
> by moving it to system_virtio_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-mem.c | 1 -
>   hw/virtio/meson.build  | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-) 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


