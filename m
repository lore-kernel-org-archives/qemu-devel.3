Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11262C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4R3W-0002GO-Fq; Tue, 07 May 2024 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R3U-0002G3-Lw
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R3T-0007tk-7i
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715112290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QU/MBP3z7rtp4vu0fCAYV9b9R17J0dSisvJEGz/yQfA=;
 b=SQybHqsM3yRigSAdCYZ92ZAK4zPojPXmcb5XqXlHAPEZSAyTWqudN2b8QtM5ei5HjakIXJ
 36Za44KEPd2WSTWUHsyJkhdVL9drsWSGCUKP4vKa/wfw/4IKbnFQqtGvyIXZ38ftxu3ZuE
 lYSsyQGOQaLuSgMc/WMsidwpowGoHfY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-TjECQ561NCWM3-nLiuPj-w-1; Tue, 07 May 2024 16:04:47 -0400
X-MC-Unique: TjECQ561NCWM3-nLiuPj-w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c864bcd2b0so299523b6e.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 13:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715112287; x=1715717087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QU/MBP3z7rtp4vu0fCAYV9b9R17J0dSisvJEGz/yQfA=;
 b=TMpsjHm+vsu3vgFIbN9Ifd1U6A2UHFL8+q8vWvrLSxWueA8ZDC2aOGH9IIYWOEahKX
 Z/GB+uV7jJVKF/L65rqyeVai1UdLpysM1kp7GmFw9SnRc3zubxI564UVwXjx6b2bLaY7
 HRdaPUdztw2avqyPeL9QHhF4G4ImxuUub8llqhPglx543MngX4sKnP2ruSCWFgFOyLes
 uCkLdN6QOSUXNJPEMp5CFB72Izg2g9OcmfgEGgm8DNYQ1jP56D4/wolMf0Qf2zvIXMgn
 932Lg7tJm+UIjNeTQDfOlCrdpyACBmT+5xJvhoqH6ai8/cA0BKF1fionF66pTezNKiq0
 KQBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUM6IuoC2g4UtmEMdTgMHWoGz+G8Wgfv6ZMqftvEVUcwWiLq25+OVp4h+ZfI5Fm3e7g6YGjuqiV+q7Uj6beJOM3JrgJJw=
X-Gm-Message-State: AOJu0Yy/SnHGf/+TccahzYE5Y+xFDRaWqOfzrHmLmz+S9LlPy2qYqG4I
 O9MlJqkYoFk6AggG3biKbUYjeC65cWQmhTe1rBKMmjzO2aZDqXtPK8qxVNp4h6IYUzUuGsplu0A
 2CogCUzU4Dkw8TqXTLmNQB4Y/x5i/iVHTFcNfON1Xy2RmqLio6v4T
X-Received: by 2002:a05:6808:200d:b0:3c8:49ef:cdf0 with SMTP id
 5614622812f47-3c9852b99a0mr677439b6e.2.1715112286670; 
 Tue, 07 May 2024 13:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE11fWZbJtW421Y6lSIKgAt52fuhRMhBoCwP/ni+JNKqFf8sw8uiPiv1edo4aRIrCcKTaEbvA==
X-Received: by 2002:a05:6808:200d:b0:3c8:49ef:cdf0 with SMTP id
 5614622812f47-3c9852b99a0mr677403b6e.2.1715112286075; 
 Tue, 07 May 2024 13:04:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f14-20020ad442ce000000b006a0fd6b745bsm4954090qvr.43.2024.05.07.13.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 13:04:45 -0700 (PDT)
Date: Tue, 7 May 2024 16:04:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: jag.raman@oracle.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v10 0/7] Support message-based DMA in vfio-user server
Message-ID: <ZjqJW88alkjCmS5I@x1n>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 07:34:24AM -0700, Mattias Nissler wrote:
> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivating use
> case is to hook up device models as PCIe endpoints to a hardware design. This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoint
> does not access memory directly, but sends memory requests TLPs to the hardware
> design in order to perform DMA.
> 
> Note that more work is needed to make message-based DMA work well: qemu
> currently breaks down DMA accesses into chunks of size 8 bytes at maximum, each
> of which will be handled in a separate vfio-user DMA request message. This is
> quite terrible for large DMA accesses, such as when nvme reads and writes
> page-sized blocks for example. Thus, I would like to improve qemu to be able to
> perform larger accesses, at least for indirect memory regions. I have something
> working locally, but since this will likely result in more involved surgery and
> discussion, I am leaving this to be addressed in a separate patch.

I assume Jag will pick this up then.

Thanks,

-- 
Peter Xu


