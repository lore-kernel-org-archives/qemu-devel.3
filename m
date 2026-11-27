Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GDknXrCE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fGrWCney
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWy93-0005N9-C7; Fri, 27 Nov 2026 10:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWy8x-0005Ho-0P
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xWy8v-0003Ni-CT
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795794342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=deAHwY0YEQGdS/Un7sf7vGFUIbFTHEYpgKOBA7xHPYU=;
 b=GDknXrCEJXSDH4DJHW+xEc5zqFBLxb2brHdD3iJ70omhVahJMxi90PCUm215NBqIHXlt1a
 KTWRNpxCDA8dyW4DgM+Q3jklce63FyRqE8nd2UXCDDSltXEbDnnys9QtrHhgJ4lCPfuKK7
 XDcCDly8a3f7pFtjjBWFB4BFljHxe64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-rZ5gxss5PXCLUDVpCock8g-1; Fri, 27 Nov 2026 15:45:40 +0000
X-MC-Unique: rZ5gxss5PXCLUDVpCock8g-1
X-Mimecast-MFC-AGG-ID: rZ5gxss5PXCLUDVpCock8g_1795794339
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso46186595e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 07:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795794339; x=1796399139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=deAHwY0YEQGdS/Un7sf7vGFUIbFTHEYpgKOBA7xHPYU=;
 b=fGrWCney+yiw7I/Ol8ShQyZbC+Fn8syhKOfOA3BUQtmyINFqMNiOfQ267uuDz970gT
 hQt2GTW+6WeryCKRufhLM6OGnEn6bgDV3t0EVSJslr9cFXTqrEfL70ZdhKtY+nSseT4g
 mRfvNidCs2AheSyke6OgqOaxS9rzVfpfQyzqPRJjcvf8IY8VgnHW29eQLTuHhNCFdL15
 U3uq4vPHNykN0+d9TBO7eXoQ2JGXDDqlkrxTLEhDUIaCYkf00KmlOkz8NdYYENWlHAK/
 BfVgP3lmk+O0cnxfb/kCESXWLG7Y88BJUJX0CqcY1FqaCWBRt/omeXKgJ8cb33/fjhM2
 wnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795794339; x=1796399139;
 h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=deAHwY0YEQGdS/Un7sf7vGFUIbFTHEYpgKOBA7xHPYU=;
 b=WccOxz4nTjg1aEvG9umHuS9DO6CLIthjK3F8TVGFR+KJeTxWlcejmJxHYEKJOpBRxi
 az2EnTlEP2UMIML0cKO7+cvRYLnJ0ite+WudzAdGlP6Q64TSNB9blqvYKh2gl5wPMeyU
 4bOvJOGvkgtGfuye/6RHhzcg96NQq3NFqfWAFttlANm7cI5CtnP9btTPunvTeQPxVGlL
 b3D20KvZ5aQ0Dq3lRwpOvAtqAo/tjpQoZRtIrTUsKgu7VZqV9SR7zlkcGFc4KDpAqq9z
 qY5+/T+grFJhIMDIxhuZIH6gg7gJz9iti2BrnhRx0iU+RKqFn+qdot1MOE37q/JfOpdS
 QUiQ==
X-Gm-Message-State: APuU4Z/M/dhd2NzUkuFLdevXN6zNimjUMrDO8najzuKyNxQXohOjMgZs
 EbHPgUc0LYky7Y9xYDnHNxzmbyU2n/fOvvx9ao+w/E4JJMZ4vuY7W8R6MAPfAhpZJvEEUTMD884
 HDxXhGBGPpoQA3ht938+9FWCaro98g5At3MuL8MQi0UUmKdzbVz0P3iPhwIhyqlJe5bDSNpTQtN
 sCq6yBxO8PtfhuCCvMdUi1StTxTRBUUvtZYta51Kg=
X-Gm-Gg: AZFdTZdDEAI9DmaQEwJ3RC/5yHXU10EMCnoe5o+TvCYZtDrldeLfDVaAvmJMvoO1q5g
 SUxZ9Up+t/G86JeIP1m9hfRl0UU/QfxYgj+Zu6YrW9lhoxHpdpKifiGi2YCMq1yjlhlfE6AMa8v
 Di6mdEoipmzbkaY0zrrQ/sFDHbPH+xs6Viryqc3WtdylxXGwCANTAYsq1l2RSPCqPldrb457vkv
 IoQeIckaOxZpP22Abn4eBKslYgxEafG5CpaGI6LpRj07cfJ9pDsN3pSjcySej8JgaEihLJEXaA3
 LgJ/lRLCoQfgO5inwVnH3sDZBTlK4VVVAYfIAVmZQqubMansDWAQGWnR1FZlNk3no+ki9TfKZDj
 V1Al33GMGbeYsNd2n5IKu/JYZZBhCU9WXGKpIH8mu3c4dvw==
X-Received: by 2002:a05:600d:4:b0:4bb:abe2:bbd4 with SMTP id
 5b1f17b1804b1-4bbabe2bcfdmr113253965e9.19.1795794338991; 
 Fri, 27 Nov 2026 07:45:38 -0800 (PST)
X-Received: by 2002:a05:600d:4:b0:4bb:abe2:bbd4 with SMTP id
 5b1f17b1804b1-4bbabe2bcfdmr113252865e9.19.1795794338424; 
 Fri, 27 Nov 2026 07:45:38 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm780884725e9.3.2026.11.27.07.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 07:45:37 -0800 (PST)
Message-ID: <7b691889-f9a9-48bd-b671-af3f44cb97a7@redhat.com>
Date: Fri, 27 Nov 2026 16:45:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Can xenfv-4.2 be removed nowadays?
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


  Hi!

As you might know, since a couple of releases, QEMU has the policy to treat 
all versioned machine types older than 6 years as obsolete and disables them 
automatically. The code then can be removed.

This week, I started looking into removing the code of the old pc-q35-4.2 
and pc-i440fx-4.2 machine types - but I got stuck with the "xenfv-4.2" 
machine since this is still calling the pc_i440fx_machine_4_2_options() 
function.

Being a Xen ignorant, this was quite confusing for me: Why is there this old 
"xenfv-4.2" machine, but not a newer one? Is it still used, or could it be 
removed nowadays, too? Or if it could not get removed completely, could it 
get replaced by a newer variant or non-versioned machine type instead?

  Thomas


