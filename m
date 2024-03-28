Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07062C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 06:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpjB8-0004bS-4G; Thu, 28 Mar 2024 02:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpjB5-0004b4-Ve
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpjB4-0001Jy-5l
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 02:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711607032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NPon+G7gwfV1a0ZGzyw3Lv/cN5zfew6FaSAilW3rrUI=;
 b=ge6sJAF7nXwuJ+S8iz2th+1E+A9JXv97g+wBuMxvh1GEp0YGfpLnYflZ4CAO9FbJFvusJJ
 Vj/YpuRH3ZwLhteU4apJz4xUnlMLyWhDMAZo7cEAcerS+8DmUotHMMOGMGr5RAIu8ar9S8
 hK6j/F5MU2SiYossBWTXzuOU8HJtxtE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-iE2kerLNPeqr7KqO0whJeQ-1; Thu, 28 Mar 2024 02:23:50 -0400
X-MC-Unique: iE2kerLNPeqr7KqO0whJeQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d298d601adso3686941fa.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711607029; x=1712211829;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPon+G7gwfV1a0ZGzyw3Lv/cN5zfew6FaSAilW3rrUI=;
 b=G4ICGENaq/tAsmQnnU+0CFX4IrZEY5xjk2Dj/I+Cyw0KfiKgsGbE5AhkwaMpBcwVEs
 QwgX6y4Pq+FcrwK6B3je4fB68J/vi5Jqw3YFrDX4e5092XNfFrb2woE/ez7ehwM5OHMs
 Xhdp6wD2Cn+FNbXIWld0OJKZG3FAfWDK6JMJ8hILuuqwYAOcKB5glwHXCcnOy6sAbGoU
 QUd5IH9dcos3lsmmoOzmHWjOzWwksi8bk8GtrCgMe7+g+L2XR3Ti3Vbur2U8rvwXnV8b
 nl3tbB5EXgE/2EzBpCNwaj3MkG1Zm28EvR/sLK5gxX18wfoeMhRt1LZV3MYLfLK01Ian
 RihQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVezPNBS4Su+VZnaBCAfH7hVdVtqAgkumQBeWw30UZxddJ4HmMeYb0MgHCRd7+axd9vBQ4aYrMhTD0MOw3OfsBOrQQL8ZY=
X-Gm-Message-State: AOJu0YwaLWytzxF+TwnMqwqh6lrFaTagwc06bMH0i+sEPpMFB/byA5v/
 SF9DQcDKKN5J5JOnawU3ohZIcR8yO7PHSWjZSAilRrJMeR3ZJ5FeMO9oX/mOj+PeUw2W9+4/d0E
 9KeOtrEVYHSdFz1KKZVtmbrpTPYWljGkl234HuvvT68XmVStssmrA
X-Received: by 2002:a2e:7815:0:b0:2d6:c14d:1530 with SMTP id
 t21-20020a2e7815000000b002d6c14d1530mr1369509ljc.37.1711607028961; 
 Wed, 27 Mar 2024 23:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXgWldm95E6CXBJ88U4RtCGURj/qUo5VONfvhRhi3//ld/rauvNZXxZCCL9OqThFxYHtgSCw==
X-Received: by 2002:a2e:7815:0:b0:2d6:c14d:1530 with SMTP id
 t21-20020a2e7815000000b002d6c14d1530mr1369502ljc.37.1711607028632; 
 Wed, 27 Mar 2024 23:23:48 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 dd12-20020a0560001e8c00b00341b749ab8bsm821185wrb.69.2024.03.27.23.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 23:23:48 -0700 (PDT)
Message-ID: <a38b17a3-4bcf-43c2-a72e-57e1ef6ea390@redhat.com>
Date: Thu, 28 Mar 2024 07:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, groug@kaod.org, peter.maydell@linaro.org,
 qemu_oss@crudebyte.com
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 27/03/2024 15.20, Daniel Henrique Barboza wrote:
> Hi,
> 
> In this new version we took a different approach after the discussions
> we had in [1]. The tests are now untouched, and we're addressing the root
> cause directly: the fact that we have a single temp dir for all the test
> execution in qos-test.
> 
> We're now creating and cleaning temp dirs for each individual test by
> calling virtio_9p_create_local_test_dir() in the .before callback for
> the local 9p tests (assign_9p_local_driver()). In this same callback we
> queue the cleanup function that will erase the created temp dir. The
> cleanup will run after the test ran successfully.
> 
> This approach is similar to what other qtests do (in fact this design was
> taken from vhost-user-test.c) so it's not like we're doing something
> novel.
> 
> I kept the revert of the slow test gate because Gitlab seems to approve
> it:
> 
> https://gitlab.com/danielhb/qemu/-/pipelines/1229836634
> 
> Feel free to take just patch 1 if we're not sure about re-enabling these
> tests in Gitlab.
> 
> 
> Changes from v3:
> - patches 1 to 6: dropped
> - patch 1 (new):
>    - create and remove temporary dirs on each test
> - v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html
> 
> Daniel Henrique Barboza (2):
>    qtest/virtio-9p-test.c: create/remove temp dirs after each test
>    qtest/virtio-9p-test.c: remove g_test_slow() gate
> 
>   tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
>   1 file changed, 11 insertions(+), 21 deletions(-)


Works for me, too!

Tested-by: Thomas Huth <thuth@redhat.com>


