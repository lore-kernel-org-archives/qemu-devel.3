Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25389C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 06:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4D72-00045L-CU; Mon, 14 Apr 2025 02:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4D6w-000442-64
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4D6t-0004rc-GK
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744611355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KoZVABeMuBG04mKaj0AlbIJwHmxUGiX8mSj2q6nfKiQ=;
 b=BFVGMyTucqR53EkkzRWbPORxplHxT4SaVGMFhZYkiKhg8OekCJxj59Q3eiAbTXcARzbK8H
 unvrtwdx3MBbxp5PccueoYX5Eky3V5tUXSrXd+ih3BxFOSge/+WPPhTRkCPwiCIl/vx/aD
 3ESfGSoWbSpQt5dQHJfis3eELYAWe5E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-UQU1Ptw7MKu30lfJ7OwQGw-1; Mon, 14 Apr 2025 02:15:54 -0400
X-MC-Unique: UQU1Ptw7MKu30lfJ7OwQGw-1
X-Mimecast-MFC-AGG-ID: UQU1Ptw7MKu30lfJ7OwQGw_1744611353
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac3d175fe71so275146766b.0
 for <qemu-devel@nongnu.org>; Sun, 13 Apr 2025 23:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744611353; x=1745216153;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoZVABeMuBG04mKaj0AlbIJwHmxUGiX8mSj2q6nfKiQ=;
 b=UdzKfCVbhlEiel0rScMDIqzyRARIdVUIczuvJ6iRXzzW1JUeJY938N2Zp8FvJGOkhb
 NdM7+f8oPPsn39bEL4fgfUPJzA5fzul7MFEcFHfHO30ejytXETwgz6N0FUnkixUHHpZ9
 CUEGWP3ubsL6cWQGqpg8Zz6QLuI8j3R0ZdpTqBmIWcT4me+JWvlStNF8uQhlUfv2xi3Y
 oe6BslS0mwTzqpTqGM83DW7Dg6+r9HySnYZxU5VZizSd22VfRXZ12XYkZ/lpSLjW4PZ/
 0YQiDqS/yls8i1PeN+IKo4jBQt4lKgipu1Qg1hyNKYR+wM9YWbx9NT673K9IeBnmlToj
 WQBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD6egg15/k/xuM1FV/DCixrYXxB9G1DSeKPFB4AfbDlW3ZEe/7YBk7J95L0B/n5kF96/40jnDJg+N8@nongnu.org
X-Gm-Message-State: AOJu0YyV3dIKXQM254h3f4KLESVkD/1viCUfxRMhAJFpPqZqM5gusvDk
 2eJuWaPUNFzGWCPS9/J/zPr7RoFmglXZpxQPbJE2Iwlwvd6NHIK1EeOsdFBtf+AUEiwuvrVZ3mZ
 Bd3pyvf/uyTpWpUhV4bu0KvL6gnuSkfxJwEJizve2U5cikjV+tT2h
X-Gm-Gg: ASbGncvQ0yKN3OulCTIoU3kgWSAgPrpKVB7zO1SCMpNmFZEMOxnM9uSJhj8SoGcCiKz
 7wU0stLAJWWnSmSpzySyI6z+CHLylabA39zAuM4I8p1WhU+XHVXQ8KYzLhq+wWs7HFDyW1RT9nT
 cCPn6Sl5WESFxKzqiejiKWux2Pk7+xcbwIleqijNCWi+MqdJC6jr/sEj/HJzkgU180gSrAUByjg
 T8ngbxd+XFSuaSHbEiB9g0gTPpm054VsVt0OXw27IxsZ1BEm8K/bOjVhtyUme6Gao2DEM+q7hZy
 d3woKMXb8WKWQh7tWdaRbv+NFi3ovmr/MwwLYp9ZdVg=
X-Received: by 2002:a17:907:3f1d:b0:aca:b45a:7c86 with SMTP id
 a640c23a62f3a-acad344567amr1061792766b.1.1744611352831; 
 Sun, 13 Apr 2025 23:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG14BjDtFO41AP50fVLQMuRhN8pqKnvtbwMGAMrBdztvlzvCnIIlGHrdVPH8auEMGYC3H5aog==
X-Received: by 2002:a17:907:3f1d:b0:aca:b45a:7c86 with SMTP id
 a640c23a62f3a-acad344567amr1061790666b.1.1744611352295; 
 Sun, 13 Apr 2025 23:15:52 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1c00c53sm846788766b.75.2025.04.13.23.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Apr 2025 23:15:51 -0700 (PDT)
Message-ID: <095590ec-a705-400f-bf05-2e5bfde34e32@redhat.com>
Date: Mon, 14 Apr 2025 08:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Generic method to check required
 devices availability
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
References: <20250219142412.77536-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250219142412.77536-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/02/2025 15.24, Philippe Mathieu-Daudé wrote:
> Not all binaries contain the same set of devices. Since some
> tests depend on specific devices, we need to check their
> availability in the binary.
> 
> QemuSystemTest::require_device() allows for system tests to
> explicitly check for a particular device. Add a similar
> check_required_devices() method which check all devices
> requested on the command line. If a device is missing, the
> test is skipped.
> 
> Example running test_aarch64_virt.py on macOS:
> 
>    ok 1 test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_with_gpu # SKIP no support for device virtio-gpu-gl-pci
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Just an idea to see if we can avoid manual require_device() calls.
> However not having a device in binary might also be a bug, so RFC...

I'm also a little bit torn by this question ... let's keep it explicit for 
now, but if the require_device() calls get too annoying one day, we can 
reconsider.

  Thomas


