Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAALR-0002zm-Ft; Thu, 23 May 2024 11:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAALO-0002zG-W8
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sAALM-00018g-M2
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716478013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhEwbXWsFDGt4qomiGYJ/DuJsNsJUcxQ8CbuUGK3OYs=;
 b=eWYXusz6rQ54/s4YoCtuaFPoJqvuxGGCIIuJ0DU41809U5nZkhCnttsXotauuxAWE8B+H3
 MGcbCg/nEFjvVUSxQn/R/8Nyd44LhbYTSnLms7JoQ6S5JRlac4L8KGPCf157ve5CHn1Ap8
 M2mtfZgcjVzI6cfHB/Q0uvUFLmP27uE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-7kk_Af_GPTuuViUAJLICDg-1; Thu, 23 May 2024 11:26:51 -0400
X-MC-Unique: 7kk_Af_GPTuuViUAJLICDg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5aa4372f365so2844493eaf.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478010; x=1717082810;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhEwbXWsFDGt4qomiGYJ/DuJsNsJUcxQ8CbuUGK3OYs=;
 b=uqTQLnowgbBHz1ShS6W/oH2llpQowC6XhZGCMtgxQIi8OBkdRR2RSRTvX6nQ6bfjDe
 ojBUTahJX3NiuSTa59bS87aC4FE5p1deUVJzQL+Fg1R4fjueY3SqXAAlSWgtbmDzYY/u
 EY20A3b1oKPrunh8bHtN1szcF3DXyIVez0LD7/T6//i+ragjy1bAxkOU9wcbuKNlUrdf
 Dfd19eaeoQDwrqoMUqOMHF7Y/CrVPN6t0DfeTYdPPUsNS3Sa8bQKW/1RQMw7pSzjI1yF
 z4LGp4hgdDjgiwaY4unKWbYuzk5/Ai+WHp7v1LFMdM5G96nViRJmT8QPhVc1D4C7Cdm3
 +tNg==
X-Gm-Message-State: AOJu0YziMX2rhbXEL5848pjGIWffpBEeDDu+viyDmmbhQTL3gS7aq2Kq
 sh7G7lflpJbSToL9oJXWU+jUpdxmaXmEmOu33PmjG7eDJ5ZeJ1I8xrhzo54E04HWhN4hYTxfRTu
 oa5tlwxYwmEq+259WbGI0OgxONFD48Fy0WCE6xo0IZgxxnbqaVHhv
X-Received: by 2002:a05:6358:c028:b0:192:59ac:6694 with SMTP id
 e5c5f4694b2df-19791ddd7fbmr495595855d.16.1716478010354; 
 Thu, 23 May 2024 08:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwD7660tXLORxPYQ+/e4tLuZ18fUVLyC1HrJFxL+8bLR2QQMsiyHmncgOUTd+/9vFIiCZ09A==
X-Received: by 2002:a05:6358:c028:b0:192:59ac:6694 with SMTP id
 e5c5f4694b2df-19791ddd7fbmr495591055d.16.1716478009888; 
 Thu, 23 May 2024 08:26:49 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6aab86b0e55sm40638126d6.85.2024.05.23.08.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:26:49 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 slp@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, 
 Raphael Norwitz <raphael@enfabrica.net>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com, 
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 12/13] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Message-ID: <4lhjggklgmgdubkx47ackroyscm4l4gdkdvys5rqpd2apmhgn5@cvtneyge6sac>
References: <20240523145522.313012-1-sgarzare@redhat.com>
 <20240523145522.313012-13-sgarzare@redhat.com>
 <06b7fd67-27d7-4afb-9fa3-2948d032efbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06b7fd67-27d7-4afb-9fa3-2948d032efbd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Thu, May 23, 2024 at 05:06:00PM GMT, David Hildenbrand wrote:
>On 23.05.24 16:55, Stefano Garzarella wrote:
>>`memory-backend-memfd` is available only on Linux while the new
>>`memory-backend-shm` can be used on any POSIX-compliant operating
>>system. Let's use it so we can run the test in multiple environments.
>>
>>Acked-by: Thomas Huth <thuth@redhat.com>
>>Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  tests/qtest/vhost-user-blk-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
>>index 117b9acd10..e945f6abf2 100644
>>--- a/tests/qtest/vhost-user-blk-test.c
>>+++ b/tests/qtest/vhost-user-blk-test.c
>>@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
>>                             vhost_user_blk_bin);
>>      g_string_append_printf(cmd_line,
>>-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
>>+            " -object memory-backend-shm,id=mem,size=256M,share=on "
>
>Can we simplifya nd drop the share=on?

Good catch! I'll do in the next version!

>
>Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for the reviews,
Stefano


