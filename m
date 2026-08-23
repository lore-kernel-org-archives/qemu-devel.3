Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913FFC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 02:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxy6c-0002J3-23; Sat, 22 Aug 2026 22:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wxy6a-0002Ir-4P
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 22:38:40 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wxy6Y-0002N6-Kr
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 22:38:39 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so1949910a91.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787452717; x=1788057517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=88/ZxSAuhJ5+KgGSbRJi+1bZ9zO9keY3eg4LzaDrlYk=;
 b=iFLdp895B85uoD4xeWNKQSb1QH9Zx3WxYykkw3p5eJpKAkayzt4nYsS6yxDR9/fG3W
 2Yyc6Y5+oZ5suGrHluec9/QsH830seL39PLyO6k9av26TrLNPTPFj5t09rUT5dDzkdVe
 /jEZkMdcpMvx7caioi8uzv3UBdox5zMMQo6yWqcTBO4QW//ylLh+0gOB1B0oUt4VPMuE
 9SUhsZbPJWdHqIHB9UtSutAHn0/bxGRXCJjilSOhC6J9czLQYDYmkeQB1e8Slpkva816
 LoaK6lSQaTzbWuVW67JHNEkiDHeSzzQqqZgy4vYZ22QdIFp7K1zZrUzr8P1jvZDR+8FS
 wakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787452717; x=1788057517;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=88/ZxSAuhJ5+KgGSbRJi+1bZ9zO9keY3eg4LzaDrlYk=;
 b=HlYPy57IAZjDeyVAcxyFzU7hmcGyK1BUFA58VS0hryVRyUIzacdWbsd18gkSnKXLTu
 Fu0q4l0jFDldAv0HIRgJDd7AM6NzNGfHLH/cYfbi9LcgOjmCmY7gkh0HvtTKtCkhuNHD
 gt99+CxCRsGLhdZLm0PMLvhfFJbrqMzdvQaIep/QchnS86Q5IIYOBZcKwN18auR7DI4Z
 uUnNIrTGFPWt953iGIcBsCeAqNaevfMhvWdEACuCj3yESuIdPIH+1F5fdYiLDMZyMk3Y
 wK6ucqo0kJ0l0vs5Nt8dMcV8oAeDbx3nt4eyG2XXCXeIyq7hxNkIUS6604KX+FuyLC4V
 cHfQ==
X-Gm-Message-State: AFuF++mMDwnGQGcmLn/GVIXWyrDARRhPsYIJ2pGBiYWSY4+emkp8t9/H
 ginkHRv6t/VoH2JDr+Nm+g8KDSVMsjDg7Tusce4Ur6ViN6VV8lrHYrAI
X-Gm-Gg: AR+sD10oZW+RoZ9xZd2DPcvbBhWR+nN9371q0DhFa6oFQHO2tJNVUUiFjW1Gt+M+QaX
 pbuPFxnNDBso4zrB10WEZr6l7T1F+tP62gtm+FgEa7KW6o5f3+fgHHtqj1ouWQmzDWXQrFLCVLy
 T7i/o53YlCCs+vaM6aPIOlEzxi7o0h/aJrAHRbIE2Z/Mbv18KlVJkXy7oWFFgSLjFcWR2Dh/OuB
 zqDUxsBgagPISFFtjvJ/h0GlWk9j+ryRYbUmOUh2TNXBXx2d1+vFhnIs3Ct2smuv3fL+XBrfXrt
 /BZy7UQnrOMOehxMFWKrgCnE+ZZDXUUGfqQPHsr8B/2MagvUXSvd2Su42iZrIxvGQnaG85MhtDP
 6B4ldn04MChxJbmCEE1C2D16a63xHPV0K9VF4U+/SQXAyV9tR2uooaJhYAcNEV6PYxHHJy2Y8pv
 pPMYASBKJc3wtfBznOVOxC4lfrh5XnKSeUykBnQWb3qpg4zdO41iU2+0Fw3OzBn8Uk/EXTfCR5m
 BDwp6EoexFM44qG+RxpJfRN1qpyKzo=
X-Received: by 2002:a17:90b:1d83:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-395c3367376mr26013767a91.4.1787452716791; 
 Sat, 22 Aug 2026 19:38:36 -0700 (PDT)
Received: from ?IPV6:fdbd:dc00:5ea1:104::14a? ([2404:9dc0:cd01::5c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9209f51sm19412402eec.22.2026.08.22.19.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2026 19:38:36 -0700 (PDT)
Message-ID: <4b1e1141-8454-4c32-abc0-439a3b93e57c@gmail.com>
Date: Sun, 23 Aug 2026 10:38:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] migration/rdma: Retry control sends on full queue
To: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
 <20260821133559.3815727-4-yanfei.xu@bytedance.com>
 <aohcYFgiDXpCWAlg@x1.local> <aohfxvS-msX0NWmt@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aohfxvS-msX0NWmt@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2026/8/21 22:25, Peter Xu wrote:
> On Fri, Aug 21, 2026 at 10:10:40AM -0400, Peter Xu wrote:
>>> +    switch (wr_id) {
>>> +    case RDMA_WRID_RDMA_WRITE:
>>> +        wr_desc = "RDMA write";
>>> +        break;
>>> +    case RDMA_WRID_SEND_CONTROL:
>>> +        wr_desc = "control send";
>>> +        break;
>>> +    default:
>>> +        wr_desc = "send work request";
>>> +        break;
>> Do we have other possibility?  I thought it should be either WRITE or SEND,
>> if so, we could g_assert_not_reached().
> Some side discussion..
>
> Since we're talking about the wrids, IIUC the whole RDMA wrid space is a
> bit messy. E.g. RDMA_WRID_SEND_CONTROL is used without having
> RDMA_WRID_CONTROL (2000, rather than 2022) for SEND control messages.
>
> IIUC the two-layered wrid name space is confusing, maybe we can rewrite the
> wrid allocation to only use one namespace with very limited wrid
> possibilities, selecting rdma->wr_data[] index based on the few
> possibilities.  My gut feeling is that's much easier to read.
I agree it would be better with using one namespace.
>
> In all cases, this will be a separate discussion, not relevant to this
> series alone, but I want to see if I'm the only one got confused by these
> two-layered RDMA_WRID_*.
It's true that the two-layered RDMA_WRID_* are not that clear, and I have to
rely on their comments to understand them.

Regards,
Yanfei
>
> Thanks,
>

