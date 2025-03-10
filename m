Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49976C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traSg-0006BF-Ii; Mon, 10 Mar 2025 06:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1traSe-00068T-Jg
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1traSd-00028D-3R
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741602854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S+X1w8qj+EQLOiCss80tgKQ/+FMcj7AAXy1RyHeLR7g=;
 b=TjVQ6vrF08eFzMzqmeRgRNgvhvV1qi+xmlyjULFzUM5QAiSFYyNWVwm00mdY8XAo3XQ1FX
 T2HAAUvwqLoV26IGAwSRXx703TQvTKbXbjJDos0ES5O7a3C7SQ2kFYlPnFDOREhCAbrpwG
 4beaGUBRxan8qlYiZkF3sCnssQqsb4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-T0jbQhIiPTi8yfWglSkR5A-1; Mon, 10 Mar 2025 06:34:12 -0400
X-MC-Unique: T0jbQhIiPTi8yfWglSkR5A-1
X-Mimecast-MFC-AGG-ID: T0jbQhIiPTi8yfWglSkR5A_1741602851
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so18106305e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741602851; x=1742207651;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+X1w8qj+EQLOiCss80tgKQ/+FMcj7AAXy1RyHeLR7g=;
 b=PdeyjNhGBUE4cbKthDD6ySIhj61tuaoqdZGKi/dBFyDZt9oCK/N+ODJ9245OqFHlTz
 ouRPYvpZ8yL4AUhTJ1qxZ7tzAoaoi4p7vVnneX9ub/bPlV6ta5D2gnULK8N4Tw1WsXaJ
 63FX3cijvnN8qaAJuxHXS6JtlA1FHSfb/OTIxQboQZBttGFeKpkDMQEm9oAPT5pE+Vwt
 KKdMSYkfdbMRRB8znpI7XLcbeumtVeXih9eXUa3K3OTYAX9oFoF5wtjfWUEJAH4I+luW
 3f8d1NFX41SixUrRYgIh/HNgAO+rrRriGFCQ3qGFFyDSssWwGfdQnGbUqcrnBJPVdyu5
 V/4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfWzEfSC/X3tjb+alOF9phD8kRt7Pm4yPYnW73moCpYvKdHIPM5Ue1DmeZoN4bY4f7pVHsmY+mQ/X2@nongnu.org
X-Gm-Message-State: AOJu0YyfGPkIcSo2wiTmNiXcdWVBv45SmyKjiRxwAAr/oa27lRYSImRJ
 x1WlaeYw2IK/wdIscfpZUTiu9qKkkFGtuO294YpnZ/MdaOrsykv80XGWjN9ZWQuP3IGVlO2ZcSb
 XTeC1fKzGgYPtojDVQsAiUs7mXJWn6OgcM/Ui3ujvLyztLmfXRt7l
X-Gm-Gg: ASbGncv5MFKWDsHPQ+Tkvq6mCyR4J9kDo6VLHvTfN+lh0svF0O644G9JMMyojPsmQak
 ZMrBD9PbzT+wWUV7OeRtYpgv4qcZUb45T2zZhVhogKD+6jwQax5dv9EmrLA5Mv84jUiRos41ROZ
 1JY5Iu9wSnDeomnq05ogLJOGGXFf44pO6Dpj+FoBvMDwn9wXs3ZmQ2RtnjC3EZhUSwBkBjrE2KZ
 Za9ffx50HtrPh5gZZ4DBhceNzjHsMUQQD48RfoVet40w0DRQGoIG1RhXYqQAMuepnLiT8j8q8L8
 ghdConKq0xFVquAeL8gwWolJmGSzfUvfFJ3GMXe5tv1ZyFw=
X-Received: by 2002:a05:600c:3b1d:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-43cfe15436emr6642725e9.18.1741602851267; 
 Mon, 10 Mar 2025 03:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC1jXUHAjH9vlgcWQn7VJCCekYeZ8/o15IpKWI6vSp4AOKXzQx6lokKbi89beXFmcNOfOgSg==
X-Received: by 2002:a05:600c:3b1d:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-43cfe15436emr6642595e9.18.1741602850926; 
 Mon, 10 Mar 2025 03:34:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1476sm14452086f8f.70.2025.03.10.03.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 03:34:10 -0700 (PDT)
Message-ID: <55210662-b291-4cfc-a56a-82a1b4133694@redhat.com>
Date: Mon, 10 Mar 2025 11:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump up arm_replay timeout
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250310102830.3752440-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250310102830.3752440-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/03/2025 11.28, Peter Maydell wrote:
> On my machine the arm_replay test takes over 2 minutes to run
> in a config with Rust enabled and debug enabled:
> 
> $ time (cd build/rust ; PYTHONPATH=../../python:../../tests/functional
> QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
> ../../tests/functional/test_arm_replay.py)
> TAP version 13
> ok 1 test_arm_replay.ArmReplay.test_cubieboard
> ok 2 test_arm_replay.ArmReplay.test_vexpressa9
> ok 3 test_arm_replay.ArmReplay.test_virt
> 1..3
> 
> real    2m16.564s
> user    2m13.461s
> sys     0m3.523s
> 
> Bump up the timeout to 4 minutes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 97c3f4ad4e9..608732bec63 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -31,6 +31,7 @@ test_timeouts = {
>     'arm_orangepi' : 540,
>     'arm_quanta_gsj' : 240,
>     'arm_raspi2' : 120,
> +  'arm_replay' : 240,
>     'arm_tuxrun' : 240,
>     'arm_sx1' : 360,
>     'intel_iommu': 300,

Reviewed-by: Thomas Huth <thuth@redhat.com>


