Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE7CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UvD-0006bk-Da; Wed, 23 Apr 2025 03:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7UvA-0006bG-VT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7Uv8-0004tP-EN
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745394805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fyWO8wny/2wNzYI8ZYoKndaAxDZ4SfxelS8/ugQ/Odw=;
 b=fXZ+WnOoSSH4HxHSziE6hsZfzYMh+uI6hww3bWPe8ypSM67lxaY0S0w6/sD9O4CD6fL8Am
 sqkQdAx4LYSknkQUPstn72lqIkZZcpkdSN+0wCYeOfZDwt0vETeH8buGF0e4w7apfOv5rK
 g1EnhXIo29t2J3R5E4cqMGBOrd48IyU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-e9YIBOigNmqrTtrLBA1pPQ-1; Wed, 23 Apr 2025 03:53:23 -0400
X-MC-Unique: e9YIBOigNmqrTtrLBA1pPQ-1
X-Mimecast-MFC-AGG-ID: e9YIBOigNmqrTtrLBA1pPQ_1745394802
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso33122675e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745394802; x=1745999602;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyWO8wny/2wNzYI8ZYoKndaAxDZ4SfxelS8/ugQ/Odw=;
 b=IrsmmRLopL2r6a/n2TFgCe4BfIYcRmGXntvMg5U+N+p+AuAJXa/rc6P2oN4qWVcWXq
 qB8t5FGV5W/sW9KrZjfqFLT9TGTSNRX+KN1LzESepQCk6uqjadpi5tpdszvlMCykuxlk
 1WHPAE5NFwFOPNGEunOaoBpocgjMrmm2M3OHALaDzMeEnP540bIq/r5AYQSynONj1xcd
 Z2ssmpzyKXuuX0zTSiDehgUp4yBuakQGn3ih6yMGerozXeLiZAPj4GAfzUQSv9w2GG15
 asEZebSiR6uSVoadVXUV1Ra0ELYcm58jOlbxDyh5xtU+kbEaiAWnjLc4oB+6QkzrmiSu
 BdrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Exoc0UiVZLve+ShVsmsf2nH0nUefU1cE4ggHPNaJIfukeA/BTf3krpzDBSH2U5s1HLG5SV2dvDF8@nongnu.org
X-Gm-Message-State: AOJu0YzAQ1+iuJhqfbKXVFTwJ13uwTrwoChAmteEI9Uc5mFSdygZT/5x
 fvarBKp4DjgOa/7sG/eEZcNOCW+3ce9nYwcQi3iasluPDBm2oVKMKrt/93q8qxeIDr8F9Hu+Lrh
 8BYmIYMcdxx9Ss4WyNOD7V9/GPJLDxn17VdITJXo3V2nlBtn11uMj
X-Gm-Gg: ASbGncvU6IuIRLkH1jJAhDpt5f/Vn/l9v+bnnC6NkLCwCOK8iiOS+zjQlNSfn/b5/cX
 5Ai1SZRwOzdE6IK/Zvo0IWS2we9/LSBZPyCPOki0gpglDbe+EQO7GVHMas7a53XWFVaRcOrNwS1
 rCzVh+y4TJI7XD1rE4Dd4sKSYXiZp6JTPk9jKOY3lL+1s6CtTDun3tidD3ILlZ/dUNb06kmSf0W
 D/CaWuVK2ED1MvNOs0tn94eKFzLt7rIas8s1yncVt4X4H0iK6IstLAw4qTSmVdhLWfrElYf9U4o
 TpNtt1zh6UZc6RG1dqLMaiQ7Ykb/gMcIidOwXPtecOU1Ny4=
X-Received: by 2002:a05:600c:1914:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-4406ab6cb1dmr146500545e9.7.1745394801937; 
 Wed, 23 Apr 2025 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG4AhRU30NaDup4do78yA2vExAyk0gIx/9bl3RdEuhOEO316s5ZTXwZbhxPU8ygszizGoi8g==
X-Received: by 2002:a05:600c:1914:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-4406ab6cb1dmr146500315e9.7.1745394801515; 
 Wed, 23 Apr 2025 00:53:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d18433sm16197655e9.1.2025.04.23.00.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 00:53:21 -0700 (PDT)
Message-ID: <e3454df1-4360-41c5-aae2-5df610914554@redhat.com>
Date: Wed, 23 Apr 2025 09:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250415140506.1516-1-rreyes@linux.ibm.com>
 <20250415140506.1516-2-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250415140506.1516-2-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Rorie,

(It's not an RFC anymore)

On 4/15/25 16:05, Rorie Reyes wrote:
> This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to specify
> an IRQ index for signaling that a change has been made to the guest's AP
> configuration. This is a placeholder for QEMU patches that use this value
> since it is a linux-headers update which includes changes that aren't
> merged into the kernel. Linux-headers patches should be generated using
> scripts/update-linux-headers.sh.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   linux-headers/linux/vfio.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 1b5e254d6a..d0426b5ec0 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -671,6 +671,7 @@ enum {
>    */
>   enum {
>   	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_CFG_CHG_IRQ_INDEX,


>   	VFIO_AP_NUM_IRQS
>   };
>   

This definition was introduced in Linux v6.15-rc1 with commit 07d89045bffe
("s390/vfio-ap: Signal eventfd when guest AP configuration is changed").
Since we just entered a new QEMU cycle (10.1), could you please send
a linux-headers/ update ?

You should use ./scripts/update-linux-headers.sh. See commit 421ee1ec6f0d
("linux-headers: Update to Linux v6.14-rc3") for an example.

Thanks,

C.




