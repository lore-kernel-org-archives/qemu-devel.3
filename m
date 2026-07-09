Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594BAC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1who5P-00050s-7y; Thu, 09 Jul 2026 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1who5K-00050I-I2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:42:36 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1who5G-0003g0-PQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 08:42:34 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-39c82d9f801so8615331fa.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783600944; x=1784205744;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jtq7nr5TqTcyF8ib11A7Ilkid5l8c0LQE3QT2fNEZ0M=;
 b=ErB4W8muKLOrsw/mG28q1WYd/SiDtTZGc7w/yIFfFU3qXpM6CJ0VEb4Q+fCbE08bsn
 DnES6mLiGknh2MWEoRJUvdIvTE+W9IfSdYXMzmJaAI2XmJbNLbCvlFQkh73iVzD88Ecj
 EbYt6fVpia0vlEdF46oDQYeZWeo0v4tJ3ZRTtJdvl6kp1/GH4u6zqZR0Rz1ew8JzjQro
 nt35JJAdTqCPjV4N66HNIJs5+6o/5IW+Y1Nn2rzN4BjL/s3iiYYnu6f/tPfJsl084Drz
 315VJNdMMJ12aobINiW1/tDA6zmxxGvXvVZ3A74AyLcSVuoL097DjXQLJ8wTBr7SxmFt
 sbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783600944; x=1784205744;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jtq7nr5TqTcyF8ib11A7Ilkid5l8c0LQE3QT2fNEZ0M=;
 b=s14WkXMx6qgEafeuhknRPW/bJwzfTTNhptlD7epWYoLPG5yOwdgn2AGOtumXJdiTSK
 mxKIeXFzLKVb6al4WH+j/gF8hLgKstlYBXc0E5wLrpm3W1olJZ90pBq8gVhOI+kZYdS8
 7viSZXdVwJ7wBERbr7Y3Mm7kqNmk7Y74XYCplYJ+BXkD58Ce19yOR4a1AsvwzEn8tT3c
 mDAyi/oTLZAWffr0U0poILFmFp/cScGhQ9qIZl0J8QwUw6bCjp3/3raiG2BoIUaqn1h/
 4sglOLq2w3qeRi7RFCe6CdlBArhETFKNRngNntVgayrGYvSqUrYLueXp4fqVk4HFoVqO
 zt/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrldpXQuLgc8zXdYJfqBJ2qDYV8ckZj3EuYmjG6pr0Jb+rtlsEeD5wtKF6Q5TDTHE9/v6tkGgRa9sZW@nongnu.org
X-Gm-Message-State: AOJu0YzslsARyiP/hrZMXAtq62SdTiufJD6tYElGSewCBJ1y7SaqWgU5
 9F7IgZqQun+SbFwdiDV0t2cQvPsuQk6z6UwggLZx3mBvH4BrJLSgIUOSVe6OXm4DzTo=
X-Gm-Gg: AfdE7ckU4PQf9QsFpW/GUGtSYGjF1pLHUNkKr07Q++Gl/JTuA7Otdv1g+LH66VKQtQ/
 wz+ouCxgIgHAte+qKg0xBp98QTuT3C9KGW0vEuJQJ6Aw0RB1mxVkSYu42wq0XEVXD469knd0yl1
 fQD9sFt0hEML/V4qyzDeanZvT9PvmzVYfboj59/lozccnF/g/yzq/0GaMTZm1CEHfgXvzFnePJH
 dQJEWKGMlNsOUtCU0Tb8LfgeLP+R0S//6s+b+vxDh40/c2mRYGEhDQaz9cNFyLtZ0IZSDiB1sd2
 4GqcfrVv5hDhIDzTEimZkeFLdNpPcJq/rhyqJGqxJ8x1RO4GEKxwMlUh9I3oOIbkRzEruQsUnFv
 mBOzBGymnIIYO1Isf48gVt5Sq+XdUNnLlIrF6pQJvH7MqxNZNNisv9GhUJ8tnf9h1r3JgK/mg3c
 L4wLArWFJw2S0OAJLwaf+9ig==
X-Received: by 2002:ac2:4563:0:b0:5b0:f9d:f7a0 with SMTP id
 2adb3069b0e04-5b011476339mr1104861e87.8.1783600944007; 
 Thu, 09 Jul 2026 05:42:24 -0700 (PDT)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bfecbsm5164417e87.64.2026.07.09.05.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:42:23 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:42:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Xiong Weimin <15927021679@163.com>
Cc: Serapheim Dimitropoulos <serapheimd@gmail.com>, stefanha@redhat.com, 
 qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 sgarzarella@redhat.com, Xie <xieyongji@bytedance.com>
Subject: Re: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
Message-ID: <ak-XIaqLG2FiBcF4@FV6GYCPJ69>
References: <20260316210600.62415-1-serapheimd@gmail.com>
 <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
 <20260320172345.4688-1-serapheimd@gmail.com>
 <1747673b.8c8c.19efe3cc66f.Coremail.15927021679@163.com>
 <akUFOeFkqtRVyHuX@FV6GYCPJ69>
 <7c793a79.8b24.19f4667c92b.Coremail.15927021679@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c793a79.8b24.19f4667c92b.Coremail.15927021679@163.com>
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=jiri@resnulli.us; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thu, Jul 09, 2026 at 12:23:54PM +0200, 15927021679@163.com wrote:
>
>
>Hi all,
>
>
>The VIRTIO_RDMA_SPEC draft is ready. The canonical copy is available in my public GitHub repository:
>
>
>https://github.com/xiongweimin1/virtio_rdma_wholeproject

got 404.


>
>
>I’ve attached a PDF for convenience, but please treat the GitHub file as the source of truth for review and iteration.
>
>
>The document formatting and code layout can still be improved, so I’m happy to revise them further if needed.
>
>
>Best,
>Xiong Weimin
>
>At 2026-07-01 20:18:17, "Jiri Pirko" <jiri@resnulli.us> wrote:
>>Thu, Jun 25, 2026 at 12:04:16PM +0200, 15927021679@163.com wrote:
>>
>>
>>[...]
>>
>>
>>>= What is working today =
>>>
>>>
>>>We now have an end-to-end stack:
>>>
>>>
>>>  guest: linux drivers/infiniband/hw/virtio/
>>>  userspace: rdma-core virtio provider
>>>  VMM: QEMU vhost-user-rdma device
>>
>>
>>Can you share links to public git repos for these? And what about
>>virtio spec?



