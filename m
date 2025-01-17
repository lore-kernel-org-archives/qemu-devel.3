Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DF7C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpUW-0002j9-C2; Fri, 17 Jan 2025 11:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpUD-0002hP-U9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:46:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpUB-0000sO-KG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:46:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43635796b48so15088535e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132372; x=1737737172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nl8KuxhtB+NX/h3bJB3DtYvNd4dS5Rvzrl4M2S/omPI=;
 b=mlmzTyDmqOjQwlJ3agpGsmbNQdm/yx9XWP/jk7DCtk+YWtEILfxrYCNoSIAtOt5K0+
 aPNTYLsxWhbqUT3GAdl0oiYY5GlhyduO99MtCrDMCo5HXZ21n7Z5zcmKTa8v/DtpvxC6
 A7PDaTs5jNoXJ10D+da8aLALgI0vLp13KEHQ0/nWRlUzGYaUua7lhOnM+qXBxcrvl39M
 E3qRcxFUV3ylihU+Ey2c+T7ulQ9T0NPUAxiX+9xGxi/fvmW3ZBGQjc7Ikp5UOcTqMXzn
 NUpSHBMDjzz3ZeWbreMbdIC8nOHHON+tT+5wWNfR7JS0Woiu4dg8HotC8wMnIooRHstg
 XHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132372; x=1737737172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl8KuxhtB+NX/h3bJB3DtYvNd4dS5Rvzrl4M2S/omPI=;
 b=mxfDj7N7aR5HJVoiRkvUFlI762YFSM3co0fth6LtMcZPD0PJl3iH3i3wC4mpoCeXSC
 QpOsiwnrd6Oj82kYSc7hIjcII9/C9lS/IvLpfGJrySqaEY9IbRg7PjLRpuzxr7DY68PE
 jdNl4ulBfaSsAH4zGXMZPybWNiFHJJ+OJ0Ffh3jRaosFnu8g/eXHHKOo0pqsYCEsI8X1
 41A1XCZhw32mSE3xU6U6Pmkm/VZ1SqU6WQVxPsAhqSsz36hH5LjuCmKtuP8DKjlhuCu4
 PPN6VH0e3Hr6axN3GAldwph2ZrxtjwmPR7jjAk+tjIpr2BlaGwuxqZLMPZWZBoQ6P51V
 3XMg==
X-Gm-Message-State: AOJu0YwhPnLVfxwArSOzgflG/FL1ZylxmqlLdGIVExB6vN3apN+yLZ+V
 YeJYHu9cGJP8YA5Gv/RlZeA6RaQkBZB+kCg3PJvEKBDyCXWSKez0PSTRC268N7Q=
X-Gm-Gg: ASbGncvy8w7JUFSJJ1mi1BmPflwQRvERzWZ/Zjg1mnzgZLwwXYRifEt/tg/WpjSFYH7
 twrNLPD0VVvjLTmnkWvdiFbZsVUhe7whNGthELsqbzn6q53+cxgQc4CrR3H/Cp58QR3fJtbSL91
 2OKpgY+tdii9JNMCSVTa8rO5R/LKhYJ+BtJhcYK8f5a0PQGExCewz2/IVeWshIjLvh1WnFvJ4p6
 oyfVnBGotGCo3xXhvl2MBQqs7cr9cVrIp36NtDy/8uOdnwC1OpxO80JQgjm1nmJk9F9LLcaTbNc
 pWnusNjKDDVGEcbuKkB6UeMO
X-Google-Smtp-Source: AGHT+IGj47y7iThBWmSQ6OngRkvSAPgxrROjJhLQQqfoJthzc/9HuCGnXvWrsF/29ePjdcgNSkWBlg==
X-Received: by 2002:a05:600c:1d0f:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-437c6afdc92mr117564705e9.9.1737132371788; 
 Fri, 17 Jan 2025 08:46:11 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f610sm38767755e9.20.2025.01.17.08.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:46:11 -0800 (PST)
Message-ID: <aa6d67eb-0ea7-43e6-98ac-ccb5977987c5@linaro.org>
Date: Fri, 17 Jan 2025 17:46:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250117053711-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117053711-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/1/25 11:37, Michael S. Tsirkin wrote:
> On Thu, Jan 16, 2025 at 12:22:26AM +0100, Philippe Mathieu-Daudé wrote:
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series only includes the 2.4 and 2.5 machines removal,
>> as it is a big enough number of LoC removed. Rest will
>> follow. Highlight is the legacy fw_cfg API removal :)
> 
> tagged, thanks!

Thanks but hold on... First Thomas made review comments I need
to address, but then Daniel clarified we can not remove these
until 10.1...


