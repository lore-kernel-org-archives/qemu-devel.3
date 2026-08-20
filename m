Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B660DC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzzW-0004Im-6X; Thu, 20 Aug 2026 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwzzU-0004IW-95
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwzzS-00038B-Lz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:27:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so2774956a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787221637; x=1787826437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=APT0Gd7ymgKguQ2uDx7fAM9H+BOn60XnT3c5sGq+Lj4=;
 b=fAww5i0fHhxzJh07Ykxzas0XkkpkR6i8+V049q6d9LBvlvkUtte7Fsqti1zvL/eXIQ
 7jPWrPYpxVG65osb+yG+lo3TjO1OtoUuu31t35SYxZjhc8pyS77XrjrHlSwQ217WXve3
 lhBr3GplQ5DnNxzDpZ7LlzknmqYw/KRPqlZyCpshEWLnyae4ErZdhDgZ92LE/hpRS3tk
 pUiFLdrMQhTglRBtSnwTFqq4V6IeypT0f/92V9QOpI0XQXtjc03uUqtkNn6jghHzY833
 SH8D//BnYnB+SmErRq+Db8Kkg52ubK4/+8gjBPFtHz31iwMPGBIrO+hBsVpqT5/z7f+6
 cEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221637; x=1787826437;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=APT0Gd7ymgKguQ2uDx7fAM9H+BOn60XnT3c5sGq+Lj4=;
 b=PeTyrUs2CVOqTMpbgjt28HU3AAeORpwAYQem7u9ZI4519yfG7teZz8H1g0v4tZ2E9+
 /Cir9rHt67eqxIE/12R/hIXmiZvrXQjNnE/xfQDykr1tjCpwuiRLX8qmvssI4dj7gw7d
 5wt6JhJkgNm/wUtTT+H/SuNXlV39hwn8bK1gjQ731yXFCPlJMDz2RreDJEcqfixjSw8m
 0HahtQK/5BwYaETLP097mNCfURTZmRPL2Sim2r2cxkFK15p1D+c7jiy/hWu6y2Hi9e7f
 GThWLIqCQG2KObvP8F6Iq+ZSHQS4nq7Nc1T8087KLXt4WugL60tViiZnY4BMgU5Xy/wT
 DFzw==
X-Gm-Message-State: AFuF++n6UX6SVP5jLBNjCCOd1LvWac+VsY/P4aLSYlRS1RFzFpm2+USY
 NAG4+KwuJzJqlMNsf/RsRmD4YhRBy2G/OR5hAgLW2ZBjQdKhfZqOv7Zc
X-Gm-Gg: AR+sD114ieQh99IBxt/Vl6tABF+HhVNMy9KsKlhQ5is9hgQO9vFW0UuVFCddXC6IiN0
 bmQiGbSPVwQt7tNAGmmIYxrvY7aWfjMo4qt3AYHhdG/X4NhbbF/5oR8HB0kylx1Oxro8nPU+ny0
 ulAvsTpEa2M7bJ+A5uYbPmGOMO0RAD1xlFuV/xvqf6ljHYgumvBQ6YpviQSBCm6eXtekIcuaaoK
 HZZ17y5UZ66J4uWA8B7tcjBA3otKiZET9Cm1EWd4DpM0A9ci8TJjJcpxkAeNp7eeW7ftOUnpNP4
 WqE6bF/aZYKT2+hPDDlDnz+I5ywgNY+5zOrrpUdrTuC24su9IPJn9gU+EEVNt6NWwmpzdkywb2N
 uhI5q1BkOsI4kUIv/Jk0snTHEduZW9Dy6wGZnPlXi7nWvhn+CeboyniQyQRT17arzVU8W7wEdaI
 9fWtqo+fQwHf/hHNxzfGiKOpI1ZrpTBOCUXiOWSG1aDwD3Ylvue3A0RgUuCrtq6KBivoZk9eFFh
 z8=
X-Received: by 2002:a17:90b:4e8f:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39580a50d67mr23443452a91.2.1787221637076; 
 Thu, 20 Aug 2026 03:27:17 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17f48sm6972799a91.2.2026.08.20.03.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 03:27:16 -0700 (PDT)
Message-ID: <80b1c870-308f-4de4-ad53-c9ecfc91da24@gmail.com>
Date: Thu, 20 Aug 2026 18:27:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] migration/rdma: Retry control sends on full queue
To: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-4-yanfei.xu@bytedance.com>
 <aoYBhxpSL5w5gQcX@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aoYBhxpSL5w5gQcX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x1034.google.com
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

Hi peter,

On 2026/8/20 03:18, Peter Xu wrote:
> On Mon, Aug 17, 2026 at 06:51:17PM +0800, Yanfei Xu wrote:
>> RAM writes and control messages share the send queue.  If
>> outstanding writes fill it, RDMA writes drain a completion and retry,
>> but control sends fail the migration.
>>
>> Drain one outstanding write and retry the control send on ENOMEM.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
>> ---
>>   migration/rdma.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 6e8436ccc1..d1f44a5f55 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -1572,9 +1572,19 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>>           memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
>>       }
>>   
>> -
>> +retry:
>>       ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
>>   
>> +    if (ret == ENOMEM && rdma->nb_sent) {
>> +        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
>> +        if (ret < 0) {
>> +            error_setg(errp, "rdma migration: failed to make room for "
>> +                       "control send");
>> +            return -1;
>> +        }
>> +        goto retry;
>> +    }
> Looks also correct, but two questions:
>
> - Should we provide a helper instead of duplicating the WRITE op handling?
>    I believe only WRITE wrids can be on the fly.

Yes, control message is syncronized, only WRITE can be on the fly. A 
helper is a good suggestion. Will do.

>
> - Could ENOMEM be returned when nb_sent==0?  If that check applies to WRITE
>    path too?

ENOMEM can be regarded as SQ is full to RDMA usage in qemu. Actually ENOMEM
is determined by provider and could have other meaning like
inline_data > qp->max_inline_data in mlx5. Based on qemu codes, I think it's
fine without nb_sent==0

In addition, I encountered this bug when I attempt to send dirty pages 
belongs
to same chunk in parallel. That could more efficiently utilizes 
throughput when
many scattered page in one chunk, and quickly exhausts SQ's WRs. Will post a
RFC with more data.

Regards,
Yanfei

>
> Thanks,
>
>> +
>>       if (ret > 0) {
>>           error_setg(errp, "Failed to use post IB SEND for control");
>>           return -1;
>> -- 
>> 2.20.1
>>

