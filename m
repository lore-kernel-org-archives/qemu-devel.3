Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03EFCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq79-0001vF-1A; Tue, 09 Sep 2025 00:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvq6y-0001uD-QC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 00:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvq6q-0003kh-Ab
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 00:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757392651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y1UepVGKBC0Mt3t6QP9hkL8HneT4LmLtsNTPLYx74Z8=;
 b=BgMWwveXrGFLuNSFadIMz3wo1htYT5oII6RwzCoPzlA+PlF3p2fMae+rUlvRtCwE/QSmfj
 PbNR1xCIwieXYLavwN/ETVx1/ggZqXE/2hoZHRYOuIIx9L1Mab/YrKukJA99aYscxd8nlS
 ICTweYdp6rhDWAlU6xPZkI1twwE3z/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-AanRXMkCN_a80l50hi434g-1; Tue, 09 Sep 2025 00:37:29 -0400
X-MC-Unique: AanRXMkCN_a80l50hi434g-1
X-Mimecast-MFC-AGG-ID: AanRXMkCN_a80l50hi434g_1757392649
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45ceeae0513so28725955e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 21:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757392648; x=1757997448;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1UepVGKBC0Mt3t6QP9hkL8HneT4LmLtsNTPLYx74Z8=;
 b=pr0at54uTzrpNAQkgoU22Wvr92H9n1vrooDM+wqUV8T8+JYV1MKDb6bvW592OxnXnA
 YVOCbaKnVL5poTk1kFmrzK7eRgoHypuJmUXYwyuoecLU/hHhBgrY4eo6aW//Jd8FX1U9
 O0hyX72fYyvg6UsDsKOyy9+rfRirlpbFgaHZl5Ri2iEScnjT+bKZdLu11H1aBBT0UkrY
 ARrQ46F+Trxwq3z7QocGmTyMhfyWWIk5OkVXWZDzswmlMh6fZY8IvN6Vd+ozMQtD1v5n
 dbY1RAsXdM3nWuBTduVs4tpIADPRldCczJjzZjOu8oIgeqZIZIMyWJcFWlQuJffJDiQY
 /I5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+y862UhL1vf/48Ibexi+OzSfzhQq1phAFwMZU5a2nBFOyWs98Yq1tsfKO+hMvAykNZXgOMqC8A955@nongnu.org
X-Gm-Message-State: AOJu0Yzg/6jlKqAM8sFr4qALDpr6oVjUt1Af8IzPSket8sBGTjChKsTw
 7JxR/eFMQ3TIMHR04B5F7qqgetWO9Fg1WGMlBLenJbDzvrCulbXmI4YTFbUKnWm/zAkKsA2g+wk
 c/kOUbtvbQGMJe0UTEAg5PexnoH05KpIjr4DOA+ml0xpZO1lCoJbuz3e4
X-Gm-Gg: ASbGncuHw4YRMGowLuwIeUPK0AJshaWgLH/y0Z/m4/Pode3LWkI9kcv98tHl8zQwZRH
 tGVcO+KCGEit35hJNb913u7fZVPIQ2t1ikwPBZ0yFiAVJHExFBNHx13OwHlRxaf6BE8x5VyT5E8
 ZuhOiLHJKpe+k7s3JHLNB5+2qsYCdYGghldyjdl3y0DY0iXBiJl2aLXiG4/K6MvyOAEaaoMbt7y
 bvA2WfUVtC5Zl/XZyMUCd6T2n4UhluMCicp/O7SDTcF8Lod/gCZPUmYu/1Y5Pt2pCjUEg9NRa0X
 u2H35DAiha4dMVcCaHBeCofFd1JCDoONjirY6bCWOI2aXHD5X2dRf765R5UTqTD2QdEQ14wRPmn
 3hdL2Qg==
X-Received: by 2002:a05:600c:1390:b0:45d:da7c:b36 with SMTP id
 5b1f17b1804b1-45ddded7614mr86069375e9.19.1757392648614; 
 Mon, 08 Sep 2025 21:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1K4moPCmFgeJ4Ls0IXCLQv3wHP25afL++HeeAMykeV0YKlkZO4dKWA1Sa8ESQurpkGiXjgA==
X-Received: by 2002:a05:600c:1390:b0:45d:da7c:b36 with SMTP id
 5b1f17b1804b1-45ddded7614mr86069195e9.19.1757392648172; 
 Mon, 08 Sep 2025 21:37:28 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df16a749fsm1822095e9.19.2025.09.08.21.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 21:37:27 -0700 (PDT)
Message-ID: <56baeaa6-b274-457c-931d-4ae76535f6dd@redhat.com>
Date: Tue, 9 Sep 2025 06:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] scripts/ci: add gitlab-failure-analysis script
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250908211859.2678847-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250908211859.2678847-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/09/2025 23.18, Alex Bennée wrote:
> This is a script designed to collect data from multiple pipelines and
> analyse the failure modes they have.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/ci/gitlab-failure-analysis | 65 ++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100755 scripts/ci/gitlab-failure-analysis

You already get a nice overview by visiting a page like 
https://gitlab.com/qemu-project/qemu/-/pipelines/2019002986 ... what's the 
advantage of this script?

  Thomas


